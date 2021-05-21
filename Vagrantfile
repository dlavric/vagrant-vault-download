# -*- mode: ruby -*-
# vi: set ft=ruby :

# download Vault by specifying the version
VAULT="1.6.2"

Vagrant.configure("2") do |config|
    config.vm.box = "hashicorp/bionic64"

    

    config.vm.define "vault" do |vault|
        vault.vm.hostname = "vault"
        vault.vm.network "private_network", ip: "192.168.56.51"
        vault.vm.provider "virtualbox" do |v|     
            v.memory = 1024 * 4
            v.cpus = 2  
    end

    vault.vm.provision "shell", path: "scripts/install_vault.sh",
      env: { "VAULT" => VAULT||=String.new }
    
    end  


# Install Azure CLI and setup azure env variables

   # config.vm.provision "file", source: "scripts/azurerm.sh", destination: "/home/vagrant/azurerm.sh"
   # config.vm.provision "shell", inline: "cat /home/vagrant/azurerm.sh >> /home/vagrant/.bashrc"
   # config.vm.provision "shell", path: "scripts/install_azurecli.sh"

# Install Terraform

   # config.vm.provision "shell", path: "scripts/install_terraform.sh"
   
    
end