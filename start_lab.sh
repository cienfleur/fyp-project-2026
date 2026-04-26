#!/usr/bin/env bash

set -euo pipefail

# input validation
if [[ $# -ne 1 ]]; then
  echo "Error: you must provide exactly one scenario name."
  echo "Usage: $0 <scenario_name>"
  exit 1
fi
export SCENARIO="$1"

# tear down existing state
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
bash "$SCRIPT_DIR/finish_lab.sh" "$SCENARIO"

# start VMWare Fusion
echo "Launching VMware Fusion"
open -a "VMware Fusion" >/dev/null 2>&1 || true
echo "  Waiting for VMware Fusion to start"
sleep 8

# vagrant up to start and provision VMS
echo "Bringing up scenario '$SCENARIO' with VMware Desktop provider"
vagrant up --provider=vmware_desktop

# verify connectivity (tends to time out)
echo ""
echo "Verifying VMs..."

echo -n "  Attacker IP: "
timeout 20 vagrant ssh attacker -- hostname -I 2>/dev/null | tr -d '\r' || echo "(timed out)"

echo -n "  Victim   IP: "
timeout 20 vagrant ssh victim -- hostname -I 2>/dev/null | tr -d '\r' || echo "(timed out)"

echo ""
echo "Scenario '$SCENARIO' is now running"
