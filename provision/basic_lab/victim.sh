#!/bin/bash

echo "Starting provisioning for Victim machine..."

# Update package index
export DEBIAN_FRONTEND=noninteractive
apt-get update -y

# Install open-vm-tools so VMware Desktop provider can communicate with this guest
apt-get install -y open-vm-tools

# Install a basic web server (Apache)
apt-get install -y apache2

# Make sure Apache is running and will start on boot
systemctl enable apache2
systemctl start apache2

# Let's create a dummy hidden file for the recon lab scenario
# This simulates a "flag" or a hidden directory that an attacker might find
mkdir -p /var/www/html/hidden_admin
echo "Congratulations! You found the hidden admin panel." > /var/www/html/hidden_admin/index.html

echo "Victim machine provisioned successfully!"
