#!/bin/bash

echo "Starting provisioning for Attacker machine..."

# Update the package index
export DEBIAN_FRONTEND=noninteractive
apt-get update -y

# Install open-vm-tools so VMware Desktop provider can communicate with this guest
apt-get install -y open-vm-tools

# Kali Linux usually comes pre-installed with most tools (nmap, gobuster, etc.)
# We can install any extra packages if necessary.
# For example, let's make sure 'net-tools' is installed for debugging networking:
apt-get install -y net-tools curl wget dirb

# Create a custom wordlist containing common directory names
cat > /home/vagrant/wordlist.txt <<'EOF'
admin
hidden
hidden_admin
secret
backup
config
login
panel
portal
private
EOF
chown vagrant:vagrant /home/vagrant/wordlist.txt

# Write the scenario instructions to the attacker's home directory
cat > /home/vagrant/lesson.txt <<'EOF'
Basic Lab: Searching through an Apache webserver

  Task:
    The victim machine (192.168.56.11) is running a
    web server with a hidden directory. Your task is
    to find it and read the message inside.

  USEFUL COMMANDS:

    Check the victim is reachable:
      ping -c 4 192.168.56.11

    Browse the victim's main web page:
      curl http://192.168.56.11/

    Enumerate hidden directories using a wordlist:
      dirb http://192.168.56.11/ ~/wordlist.txt

    Access a discovered path directly:
      curl http://192.168.56.11/<path>/

=====================================================
EOF
chown vagrant:vagrant /home/vagrant/lesson.txt

echo "Attacker machine provisioned successfully"
