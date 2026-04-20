#!/bin/bash
# ---------------------------------------------------------------
# Weak Credentials Lab – Victim Provisioning
# ---------------------------------------------------------------
# Sets up an SSH server with a deliberately weak user account.
#
# The student's goal is to:
#   1. Discover that SSH is running (nmap)
#   2. Brute-force the password for 'ctfuser' (hydra)
#   3. Log in and read the flag
#
# Account:
#   Username: ctfuser
#   Password: letmein  (deliberately weak – in common wordlists)
# ---------------------------------------------------------------

echo "Starting provisioning for Victim machine (weak_creds_lab)..."

export DEBIAN_FRONTEND=noninteractive
apt-get update -y

# Install open-vm-tools so VMware Desktop provider can communicate with this guest
apt-get install -y open-vm-tools

# --- Install and configure SSH ---
apt-get install -y openssh-server

# Ensure password authentication is enabled (some images disable it)
sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^#\?ChallengeResponseAuthentication.*/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config

systemctl restart sshd
systemctl enable sshd

# --- Create the target user with a weak password ---
useradd -m -s /bin/bash ctfuser
echo "ctfuser:letmein" | chpasswd

# --- Place the flag in the user's home directory ---
echo "FLAG{brute_force_success_2026}" > /home/ctfuser/flag.txt
chown ctfuser:ctfuser /home/ctfuser/flag.txt
chmod 400 /home/ctfuser/flag.txt

# --- Add a hint file in /var/www for anyone who looks ---
mkdir -p /var/www/html
cat > /var/www/html/index.html <<'EOF'
<html>
<head><title>Weak Credentials Lab</title></head>
<body>
<h1>Weak Credentials Lab</h1>
<p>There is a user on this system with a very weak password.</p>
<p>Hint: the username is <code>ctfuser</code>. Can you find the password?</p>
</body>
</html>
EOF

# Install Apache so the hint page is accessible via HTTP
apt-get install -y apache2
systemctl enable apache2
systemctl start apache2

echo ""
echo "====================================================="
echo "  WEAK CREDENTIALS LAB – Victim Ready"
echo "====================================================="
echo "  User 'ctfuser' has been created with a weak password."
echo "  A flag has been placed in /home/ctfuser/flag.txt"
echo "====================================================="
echo ""
echo "Victim machine provisioned successfully!"
