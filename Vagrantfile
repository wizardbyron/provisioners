# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
LOCALE = "cn"
DISTOR = "ubuntu" # or ubuntu

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.define "master", primary: true do |master|
    master.vm.box_check_update = true
    # master.vm.box = "centos/7"
    master.vm.box = "ubuntu/xenial64"

    master.vm.provider "virtualbox" do |v|
      v.name = "master"
      v.memory = 4096
      v.cpus = 2
    end

    #Private_network Settings
    master.vm.network "private_network", ip: "192.168.100.100"

    #SSH
    master.ssh.forward_agent = true
    master.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Linux distro
    master.vm.provision "shell", path: "distro/#{DISTOR}/provision.sh", args: "#{LOCALE}", privileged: false
    
    # Facilities
    master.vm.provision "shell", path: "facilities/docker-ce/docker-#{DISTOR}.sh", args: "#{LOCALE}", privileged: false
    # master.vm.provision "shell", path: "facilities/k8s/common-#{DISTOR}.sh", args: "#{LOCALE}", privileged: false
    # master.vm.provision "shell", path: "facilities/k8s/master-#{DISTOR}.sh", args: "#{LOCALE}", privileged: false
    # config.vm.provision "shell", path: "facilities/jenkins/jenkins-#{DISTOR}.sh", privileged: false
      
  end

  # config.vm.define "worker1" do |worker1|
  #   worker1.vm.box_check_update = true
  #   worker1.vm.box = "centos/7"
  #   worker1.vm.box = "ubuntu/xenial64"

  #   worker1.vm.provider "virtualbox" do |v|
  #     v.name = "worker-01"
  #     v.memory = 2096
  #     v.cpus = 2
  #   end

  #   #Private_network Settings
  #   worker1.vm.network "private_network", ip: "192.168.100.101"

  #   #SSH
  #   worker1.ssh.forward_agent = true
  #   worker1.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  #   worker1.vm.provision "shell", path: "distro/#{DISTOR}/provision.sh", args: "#{LOCALE}", privileged: false
  #   worker1.vm.provision "shell", path: "facilities/docker-ce/docker-#{DISTOR}.sh", args: "#{LOCALE}", privileged: false
  #   worker1.vm.provision "shell", path: "facilities/k8s/common-#{DISTOR}.sh", args: "#{LOCALE}", privileged: false
  #   # config.vm.provision "shell", path: "facilities/jenkins/jenkins-worker-#{DISTOR}.sh" , privileged: false
  # end
  
end
