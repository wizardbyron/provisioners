# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
DISTRO = "centos" # or ubuntu
CLUSTER_IP = "10.0.100.100"
WORKER_NODES = 2
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
    master.vm.hostname = 'master-node'

    #SSH
    master.ssh.forward_agent = true
    master.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

    # Linux distro
    master.vm.provision "shell", path: "distro/#{DISTRO}/provision.sh", args: "", privileged: false
    
    # Facilities
    master.vm.provision "shell", path: "facilities/docker-ce/docker-#{DISTRO}.sh", args: "", privileged: false
    master.vm.provision "shell", path: "facilities/k8s/installation-#{DISTRO}.sh", args: "", privileged: false
    master.vm.provision "shell", path: "facilities/k8s/setup-cluster.sh", args: "#{CLUSTER_IP}", privileged: false
    # master.vm.provision "shell", path: "facilities/jenkins/jenkins-#{DISTRO}.sh", privileged: false

    # Cloud Platform
    master.vm.provision "shell", path: "cloud/aws/awscli-docker.sh", args: "", privileged: false
  end

  (1..WORKER_NODES).each do |i|
    config.vm.define "worker-#{i}", autostart:true do |worker|
      worker.vm.box_check_update = true
      worker.vm.box = "#{boxes[DISTRO]}"

      worker.vm.provider "virtualbox" do |v|
        v.name = "worker-node-#{i}"
        v.memory = 2048
        v.cpus = 2
      end

      worker.vm.synced_folder ".", "/vagrant", type: "rsync"

      #Private_network Settings
      worker.vm.network "private_network", ip: "10.0.100.10#{i}"
      worker.vm.hostname = "worker-#{i}"

      #SSH
      worker.ssh.forward_agent = true
      worker.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      # Linux distro
      worker.vm.provision "shell", path: "distro/#{DISTRO}/provision.sh", args: "", privileged: false

      # Facilities
      worker.vm.provision "shell", path: "facilities/docker-ce/docker-#{DISTRO}.sh", args: "", privileged: false
      worker.vm.provision "shell", path: "facilities/k8s/installation-#{DISTRO}.sh", args: "", privileged: false
      worker.vm.provision "shell", path: "facilities/k8s/setup-worker.sh", args: "#{CLUSTER_IP}", privileged: false
    end
  end
end
