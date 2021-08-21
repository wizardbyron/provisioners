#!/usr/bin/env bash
export PATH=$PATH:/home/$(whoami)/.local/bin
export MIRROR=$1
echo "Install and upgrade packages via package manager. MIRROR:$MIRROR"
if [ -n "$(command -v yum)" ];then # for centos
sudo cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
sudo yum update -y
sudo yum upgrade -y
sudo yum install -y epel-release yum-utils git wget python3-pip unzip
sudo systemctl enable firewalld
sudo systemctl start firewalld
elif [ -n "$(command -v apt)" ];then # ubuntu
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
if [ $MIRROR = "tencent" ];then
sudo sed -i 's/archive.ubuntu.com/mirrors.tencent.com/g' /etc/apt/sources.list
fi
sudo apt update -y
sudo apt install -y software-properties-common git firewalld curl python3-pip unzip
sudo apt dist-upgrade -y
sudo systemctl enable firewalld
sudo systemctl start firewalld
else
echo "Your Linux package manager hasn't support"
exit 1
fi

echo "Upgrade pip."
if [ $MIRROR = "tencent" ];then
sudo python3 -m pip install --upgrade -i https://mirrors.cloud.tencent.com/pypi/simple pip
else
sudo python3 -m pip install --upgrade pip
fi

echo "Install Ansible."
if [ $MIRROR = "tencent" ];then
python3 -m pip install -i https://mirrors.cloud.tencent.com/pypi/simple --user ansible
else
python3 -m pip install --user ansible
fi

echo "Install docker-ce via official installation script."
curl -fsSL https://get.docker.com | sudo bash

if [ $? = 0 ]; then
sudo usermod -aG docker $(whoami)
sudo systemctl enable docker
sudo systemctl restart docker
if [ $MIRROR = "tencent" ];then
python3 -m pip install -i https://mirrors.cloud.tencent.com/pypi/simple docker-compose
else
python3 -m pip install docker-compose
fi
else
echo "Install docker-ce failed, Please retry or install with mirror."
exit 1
fi
