#!/usr/bin/env bash
sudo sh -c "echo 'export LC_ALL=C.UTF-8' >> /home/vagrant/.bashrc"
sudo sh -c "echo 'export LANG=C.UTF-8' >> /home/vagrant/.bashrc"
sudo sh -c "cp /etc/apt/sources.list /etc/apt/sources.list.bak"
sudo sh -c "cp /vagrant/sources/xenial.list /etc/apt/sources.list"
sudo locale-gen zh_CN.UTF-8

# Update and upgrade packages
sudo apt update -y
sudo apt dist-upgrade -y

# Install Docker
curl -fsSL https://get.docker.com | sudo bash -s docker --mirror Aliyun
sudo usermod -aG docker vagrant

# Install common packages
sudo apt install -y docker-compose htop
