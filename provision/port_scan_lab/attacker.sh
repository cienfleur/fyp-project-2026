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

echo "Attacker machine provisioned successfully!"
