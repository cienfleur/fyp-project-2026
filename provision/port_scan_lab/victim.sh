#!/bin/bash
# ---------------------------------------------------------------
# Port Scan Lab – Victim Provisioning
# ---------------------------------------------------------------
# Sets up multiple services on non-standard ports for the student
# to discover via port scanning.
#
# Services:
#   Port 2222  – SSH (moved from default 22)
#   Port 8888  – Python HTTP server serving a clue page
#   Port 4444  – Netcat listener that returns the flag
#   Port 9090  – A decoy service (red herring)
#
# The student must find all open ports and connect to port 4444
# to retrieve the flag.
# ---------------------------------------------------------------

echo "Starting provisioning for Victim machine (port_scan_lab)..."

export DEBIAN_FRONTEND=noninteractive
apt-get update -y

# Install open-vm-tools so VMware Desktop provider can communicate with this guest
apt-get install -y open-vm-tools

# --- SSH on a non-standard port ---
# Port 22 is kept open so Vagrant can still manage the VM.
# Port 2222 is added as the non-standard port the student must discover.
apt-get install -y openssh-server
sed -i 's/#Port 22/Port 22\nPort 2222/' /etc/ssh/sshd_config
systemctl restart sshd

# --- Python HTTP server on port 8888 with a clue ---
apt-get install -y python3
mkdir -p /var/www/clue
cat > /var/www/clue/index.html <<'EOF'
<html>
<head><title>Clue</title></head>
<body>
<h1>Well done!</h1>
<p>You found the HTTP server. But the real flag isn't here...</p>
<p>Hint: there's another service listening on a higher port. Try connecting with <code>netcat</code>.</p>
</body>
</html>
EOF

cat > /etc/systemd/system/clue-http.service <<'EOF'
[Unit]
Description=Port Scan Lab – Clue HTTP server (port 8888)
After=network.target

[Service]
WorkingDirectory=/var/www/clue
ExecStart=/usr/bin/python3 -m http.server 8888
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# --- Netcat listener on port 4444 with the flag ---
cat > /usr/local/bin/flag_listener.sh <<'EOF'
#!/bin/bash
while true; do
  echo "FLAG{port_scan_master_2026}" | nc -lp 4444 -q 1
  sleep 1
done
EOF
chmod +x /usr/local/bin/flag_listener.sh

cat > /etc/systemd/system/flag-listener.service <<'EOF'
[Unit]
Description=Port Scan Lab – Flag listener (port 4444)
After=network.target

[Service]
ExecStart=/usr/local/bin/flag_listener.sh
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# --- Decoy service on port 9090 (red herring) ---
cat > /usr/local/bin/decoy.sh <<'EOF'
#!/bin/bash
while true; do
  echo "Nothing interesting here. Keep looking!" | nc -lp 9090 -q 1
  sleep 1
done
EOF
chmod +x /usr/local/bin/decoy.sh

cat > /etc/systemd/system/decoy.service <<'EOF'
[Unit]
Description=Port Scan Lab – Decoy service (port 9090)
After=network.target

[Service]
ExecStart=/usr/local/bin/decoy.sh
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# --- Enable and start all three services ---
systemctl daemon-reload
systemctl enable clue-http.service flag-listener.service decoy.service
systemctl start  clue-http.service flag-listener.service decoy.service

echo "Victim machine provisioned successfully!"
