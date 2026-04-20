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

echo ""
echo "====================================================="
echo "  WEAK CREDENTIALS LAB – Attacker Ready"
echo "====================================================="
echo "  A wordlist has been placed at ~/wordlist.txt"
echo "  Use hydra to brute-force the victim's SSH service."
echo "  Example:"
echo "    hydra -l ctfuser -P ~/wordlist.txt ssh://192.168.56.41"
echo "====================================================="
echo ""
echo "Attacker machine provisioned successfully!"
