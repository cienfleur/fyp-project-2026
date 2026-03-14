#!/usr/bin/env bash
# Spin up the recon_lab scenario using Vagrant with VMware Desktop provider
SCENARIO=recon_lab vagrant up --provider=vmware_desktop "$@"
