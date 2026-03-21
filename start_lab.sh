#!/bin/bash

# Usage: ./spin_scenario.sh <scenario_name>
# Example: ./spin_scenario.sh recon_lab_demo

if [ -z "$1" ]; then
  echo "Error: No scenario name provided."
  echo "Usage: $0 <scenario_name>"
  exit 1
fi

SCENARIO=$1

# Export the SCENARIO variable for Vagrant and bring up the machines
export SCENARIO

echo "Spinning up scenario '$SCENARIO' with VMware Desktop provider..."

vagrant up --provider=vmware_desktop
