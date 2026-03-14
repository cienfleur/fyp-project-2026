#!/usr/bin/env bash
# Spin up the recon_lab scenario using Vagrant with VMware Desktop provider
SCENARIO=recon_lab_demo vagrant up --provider=vmware_desktop "$@"
