Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.boot_timeout = 600
  config.vm.graceful_halt_timeout = 120

  # Attacker Machine
  config.vm.define "attacker" do |attacker|
    attacker.vm.box = "uwbbi/bionic-arm64"
    attacker.vm.hostname = "attacker"
    attacker.vm.network "private_network", ip: "192.168.56.10"
    attacker.vm.provider "vmware_desktop" do |v|
      v.vmx["memsize"] = "1024"
      v.vmx["numvcpus"] = "1"
    end
    attacker.vm.provision "shell", path: "provision/basic_lab/attacker.sh"
  end

  # Victim Machine
  config.vm.define "victim" do |victim|
    victim.vm.box = "uwbbi/bionic-arm64"
    victim.vm.hostname = "victim"
    victim.vm.network "private_network", ip: "192.168.56.11"
    victim.vm.provider "vmware_desktop" do |v|
      v.vmx["memsize"] = "1024"
      v.vmx["numvcpus"] = "1"
    end
    victim.vm.provision "shell", path: "provision/basic_lab/victim.sh"
  end

end
