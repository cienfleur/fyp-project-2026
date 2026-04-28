#!/bin/bash
# ---------------------------------------------------------------
# Port Scan Lab – Attacker Provisioning
# ---------------------------------------------------------------
# Installs reconnaissance tools the student will need:
#   nmap   – port/service scanning
#   netcat – connecting to discovered services
#   curl   – HTTP requests
# ---------------------------------------------------------------

echo "Starting provisioning for Attacker machine (port_scan_lab)..."

export DEBIAN_FRONTEND=noninteractive
apt-get update -y

# Install open-vm-tools so VMware Desktop provider can communicate with this guest
apt-get install -y open-vm-tools

apt-get install -y net-tools curl wget nmap netcat

# Write the scenario instructions to the attacker's home directory
cat > /home/vagrant/lesson.txt <<'EOF'
Port Scan Lab: Discovering services on a target machine

  Task:
    The victim machine (192.168.56.31) is running several
    services on non-standard ports. Your task is to use nmap to find all
    open ports, investigate each one, and retrieve the flag.

  USEFUL COMMANDS:

    Scan the victim for all open ports:
      nmap -p- 192.168.56.31

    Fetch the contents of an HTTP service:
      curl http://192.168.56.31:<port>/

    Connect to a raw TCP service:
      nc 192.168.56.31 <port>

=====================================================
EOF
chown vagrant:vagrant /home/vagrant/lesson.txt

echo "Attacker machine provisioned successfully!"
