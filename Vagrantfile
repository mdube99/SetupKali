# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "kalilinux/rolling"
  config.vm.box_check_update = false
  config.vm.hostname = "kali-linux"
  config.vm.provider "VMware" do |vb|
  # Display the vmware GUI when booting the machine
     vb.gui = false
     vb.memory = "2048"
  end
end
