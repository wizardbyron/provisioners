# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
PLATFORM="vagrant" # vagrant/aws
BOXES ={
  "ubuntu" => "ubuntu/focal64",
  "centos" => "centos/7"
}
DISTRO = "centos" # centos or ubuntu
MIRROR = "tencent" # <empty>/tencent/aliyun
DOMAIN_NAME = "example.org"
CLUSTER_IP = "10.0.100.100"
WORKER_NODES = 0
SOLUTION = "default" # default/devops/k8s

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.define "master", primary: true do |master|
    master.vm.box_check_update = true
    master.vm.box = "#{BOXES[DISTRO]}"

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

    # Provision Master Node
    master.vm.provision "shell", path: "./essential/#{PLATFORM}/init.sh", args: "#{MIRROR}", privileged: false, reset: true
    master.vm.provision "shell", path: "./solutions/#{SOLUTION}/master/#{PLATFORM}/setup.sh", args: "#{MIRROR} #{DOMAIN_NAME} #{CLUSTER_IP}", privileged: false, reset: true
  end

  (1..WORKER_NODES).each do |i|
    config.vm.define "worker-#{i}", autostart:true do |worker|
      worker.vm.box_check_update = true
      worker.vm.box = "#{BOXES[DISTRO]}"

      worker.vm.provider "virtualbox" do |v|
        v.name = "worker-node-#{i}"
        v.memory = 2048
        v.cpus = 2
      end

      worker.vm.synced_folder ".", "/vagrant", type: "rsync"

      # Private_network Settings
      worker.vm.network "private_network", ip: "10.0.100.10#{i}"
      worker.vm.hostname = "worker-#{i}"

      # SSH
      worker.ssh.forward_agent = true
      worker.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

      # Provision Worker Node
      worker.vm.provision "shell", path: "./essential/#{PLATFORM}/init.sh", args: "#{MIRROR}", privileged: false, reset: true
      worker.vm.provision "shell", path: "./solutions/#{SOLUTION}/worker/#{PLATFORM}/setup.sh", args: "#{MIRROR} #{CLUSTER_IP} #{DOMAIN_NAME}", privileged: false, reset: true
    end
  end
end
