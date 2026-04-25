#!/usr/bin/env bash
set -euo pipefail

# validate input
if [[ $# -ne 1 ]]; then
  echo "Error: you must provide exactly one scenario name"
  echo "Usage: $0 <scenario_name>"
  exit 1
fi
export SCENARIO="$1"

echo "Tearing down scenario '$SCENARIO'"

# destroy VMs
echo "Destroying VMs"
vagrant destroy -f || true

# kill stray vagrant processes
echo "Killing stray Vagrant/VMware processes"
if pids=$(pgrep -f "(vagrant|vmrun|ruby)" 2>/dev/null); then
  echo "  Found: $pids — killing"
  kill -9 $pids || true
  sleep 2
else
  echo "  None found."
fi

# remove lock files
echo "Removing Vagrant lock files"
LOCKS=$(find .vagrant -type f -name "*.lock" 2>/dev/null || true)
if [[ -n "$LOCKS" ]]; then
  echo "$LOCKS" | xargs rm -f
  echo "  Lock files removed."
else
  echo "  None found."
fi

# prune global state
echo "Pruning stale Vagrant global state"
vagrant global-status --prune > /dev/null 2>&1 || true

echo ""
echo "Scenario '$SCENARIO' torn down. Safe to run start_lab.sh."
