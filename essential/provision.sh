#!/usr/bin/env bash
export CLUSTER_IP=$1
echo "Cluster IP: $CLUSTER_IP"
export PATH=$PATH:/home/$(whoami)/.local/bin
# for CentOS/RHEL
if [ -n "$(command -v yum)" ];then
sudo cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.origin
sudo yum update -y
sudo yum upgrade -y
sudo yum install -y git wget yum-utils python3-pip
# for Ubuntu/Debian
elif [ -n "$(command -v apt)" ];then 
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt install -y software-properties-common git firewalld curl python3-pip
else
echo "Your linux package manager hasn't support"
exit 1
fi

curl -fsSL https://bootstrap.pypa.io/get-pip.py |sudo python3

sudo python3 -m pip install -i https://pypi.tuna.tsinghua.edu.cn/pypi/simple --upgrade pip
sudo python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/pypi/simple

echo "Install Ansible via pip."
python3 -m pip install --user ansible

echo "Install docker-ce via official installation script."
curl -fsSL https://get.docker.com | sudo bash

if [ $? = 0 ]; then
sudo usermod -aG docker $(whoami)
sudo systemctl restart docker
python3 -m pip install docker-compose
fi