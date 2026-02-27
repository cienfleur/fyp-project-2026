Vagrant.configure("2") do |config|

  # Attacker Machine
  config.vm.define "attacker" do |attacker|
    attacker.vm.box = "kalilinux/rolling"
    attacker.vm.hostname = "attacker"
    attacker.vm.network "private_network", ip: "192.168.56.10"
    attacker.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end
    attacker.vm.provision "shell", path: "provision/attacker.sh"
  end

  # Victim Machine
  config.vm.define "victim" do |victim|
    victim.vm.box = "ubuntu/bionic64"
    victim.vm.hostname = "victim"
    victim.vm.network "private_network", ip: "192.168.56.11"
    victim.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 1
    end
    victim.vm.provision "shell", path: "provision/victim.sh"
  end

end
