#!/usr/bin/env bash
sudo yum -y remove docker docker-common docker-selinux docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2 get git
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sudo yum install -y docker-ce
sudo usermod -aG docker vagrant
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
