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
apt-get install -y net-tools curl wget

echo "Attacker machine provisioned successfully!"
