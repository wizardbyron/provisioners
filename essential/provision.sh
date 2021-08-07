#!/usr/bin/env bash
export CLUSTER_IP=$1
echo "Cluster IP: $CLUSTER_IP"
export PATH=$PATH:/home/$(whoami)/.local/bin

echo "Install and upgrade packages via package manager."
if [ -n "$(command -v yum)" ];then # for centos
sudo cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
sudo yum update -y
sudo yum upgrade -y
sudo yum install -y yum-utils git wget python3-pip
elif [ -n "$(command -v apt)" ];then # ubuntu
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt install -y software-properties-common git firewalld curl python3-pip
else
echo "Your Linux package manager hasn't support"
exit 1
fi

echo "Upgrade pip."
sudo python3 -m pip install --upgrade pip

echo "Install Ansible."
python3 -m pip install --user ansible

echo "Install docker-ce via official installation script."
curl -fsSL https://get.docker.com | sudo bash

if [ $? = 0 ]; then
sudo usermod -aG docker $(whoami)
sudo systemctl restart docker
python3 -m pip install docker-compose
fi

echo "Get latest provisioners scripts"
rm -rf provisioners
git clone https://github.com/wizardbyron/provisioners