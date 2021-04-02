# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box_check_update = true
  config.vm.box = "centos/7"
  # config.vm.box_url = "https://mirrors.ustc.edu.cn/centos-cloud/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-2004_01.VirtualBox.box"

  config.vm.provider "virtualbox" do |v|
    v.name = "provisioners"
    v.memory = 4096
    v.cpus = 2
  end

  #Private_network Settings
  config.vm.network "private_network", ip: "192.168.100.100"

  #SSH
  config.ssh.forward_agent = true
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  # Linux distro
  config.vm.provision "shell", path: "distro/centos/provision.sh"
  
  # Facilities
  config.vm.provision "shell", path: "facilities/docker-ce/docker-centos.sh"
  config.vm.provision "shell", path: "facilities/k8s/master-centos.sh"
  # config.vm.provision "shell", path: "facilities/jenkins/jenkins-centos.sh"
end
