# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
LOCALE = "cn" # for mirror
DISTRO = "centos" # or ubuntu
CLUSTER_IP = "10.0.100.100"
boxes ={
  "ubuntu" => "ubuntu/xenial64",
  "centos" => "centos/7",
  "amazon" => "bento/amazonlinux-2"
}

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.define "master", primary: true do |master|
    master.vm.box_check_update = true
    master.vm.box = "#{boxes[DISTRO]}"

    master.vm.provider "virtualbox" do |v|
      v.name = "master"
      v.memory = 4096
      v.cpus = 2
    end

    master.vm.synced_folder ".", "/vagrant", type: "rsync"

    #Private_network Settings
    master.vm.network "private_network", ip: "#{CLUSTER_IP}"
    master.vm.hostname = 'master'

    #SSH
    master.ssh.forward_agent = true
    master.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Linux distro
    master.vm.provision "shell", path: "distro/#{DISTRO}/provision.sh", args: "#{LOCALE}", privileged: false
    
    # Facilities
    master.vm.provision "shell", path: "facilities/docker-ce/docker-#{DISTRO}.sh", args: "#{LOCALE}", privileged: false
    master.vm.provision "shell", path: "facilities/k8s/common-#{DISTRO}.sh", args: "#{LOCALE}", privileged: false
    master.vm.provision "shell", path: "facilities/k8s/master-#{DISTRO}.sh", args: "#{LOCALE} #{CLUSTER_IP}", privileged: false
    # config.vm.provision "shell", path: "facilities/jenkins/jenkins-#{DISTRO}.sh", privileged: false

    # Platform
    # master.vm.provision "shell", path: "cloud/aws/cli-docker.sh", args: "#{LOCALE}", privileged: false
  end

  config.vm.define "worker1" do |worker1|
    worker1.vm.box_check_update = true
    worker1.vm.box = "#{boxes[DISTRO]}"

    worker1.vm.provider "virtualbox" do |v|
      v.name = "worker-01"
      v.memory = 2048
      v.cpus = 2
    end

    worker1.vm.synced_folder ".", "/vagrant", type: "rsync"

    #Private_network Settings
    worker1.vm.network "private_network", ip: "10.0.100.101"
    worker1.vm.hostname = 'worker1'

    #SSH
    worker1.ssh.forward_agent = true
    worker1.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Linux distro
    worker1.vm.provision "shell", path: "distro/#{DISTRO}/provision.sh", args: "#{LOCALE}", privileged: false

    # Facilities
    worker1.vm.provision "shell", path: "facilities/docker-ce/docker-#{DISTRO}.sh", args: "#{LOCALE}", privileged: false
    worker1.vm.provision "shell", path: "facilities/k8s/common-#{DISTRO}.sh", args: "#{LOCALE}", privileged: false
    # worker1.vm.provision "shell", path: "facilities/k8s/worker-#{DISTRO}.sh", args: "#{LOCALE} #{CLUSTER_IP}", privileged: false
  end
  
end
