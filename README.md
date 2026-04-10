# GuppyLab
# Automated Cybersecurity Lab System

A system for automating the deployment of simulated cybersecurity lab environments for educational purposes. This project uses Vagrant to orchestrate virtual machines and provisioning scripts to set up realistic attack and victim scenarios.
GuppyLab is a system for automating the deployment of simulated cybersecurity lab environments for educational purposes. This project uses Vagrant to spin up virtual machines and, using provisioning and configuration scripts, sets up mini CTF-like scenarios for the user to explore basic cybersecurity functions.

## Features

- **Automated VM Provisioning**: Deploy multiple virtual machines (e.g., Kali Linux attackers, vulnerable Windows/Linux victims) with a single command.
- **Scenario-Based Environments**: Pre-configured labs for specific learning objectives, such as network reconnaissance, vulnerability exploitation, and basic forensics.
- **Network Isolation**: Ensures all lab environments run in isolated virtual networks, independent of the host system.
- **Reproducible Setup**: Define entire lab topologies in code (Vagrantfiles) for consistent deployment across different machines.

## Getting Started

### Prerequisites

- **Vagrant**: Installed and configured.
- **Virtualization Provider**: Support for VirtualBox (or VMware Desktop) as the provider.

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd fyp-project-2026
   ```

### Usage

#### Deploy a Scenario

To start a pre-defined lab scenario (e.g., the 'recon_lab'):

```
./start_lab.sh <scenario name>
```

This command will:
1. Download the necessary base box images (if not already cached).
2. Create and configure the virtual machines.
3. Run any provisioning scripts to set up services and vulnerabilities.

#### Accessing Machines

You can SSH into any deployed machine:

```bash
# Access the attacker machine
vagrant ssh attacker

# Access the victim machine
vagrant ssh victim
```

#### Cleaning Up

To stop and remove all resources associated with a scenario:

```bash
vagrant destroy
```

## Scenario Examples

### Reconnaissance Lab

The `scenarios/recon_lab.rb` file sets up a basic lab with:
- **Attacker Machine**: Kali Linux equipped with penetration testing tools (nmap, gobuster, etc.).
- **Victim Machine**: A Linux server running a web server with a hidden directory for discovery practice.

## Development

### Adding a New Scenario

To create a new lab scenario:
1. Create a new Ruby file in the `scenarios/` directory (e.g., `scenarios/new_scenario.rb`).
2. Define the virtual machines and network topology using the Vagrant DSL.
3. Add a provisioning script to the `provision/<lab_name>` directory for the victim machine.
4. Document the scenario in the main project documentation.

### Provisioning Scripts

Provisioning scripts (in the `provision/` directory) are executed inside the VMs after they are created.
- `provision/<lab_name>/attacker.sh`: Sets up the attack machine.
- `provision/<lab_name>/victim.sh`: Configures the victim machine with services and vulnerabilities to be tested.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.