#!/usr/bin/env bash
sudo sed -e 's|^mirrorlist=|#mirrorlist=|g' \
         -e 's|^#baseurl=http://mirror.centos.org|baseurl=https://mirrors.tuna.tsinghua.edu.cn|g' \
         -i.bak \
         /etc/yum.repos.d/CentOS-*.repo
sudo yum update -y
sudo yum upgrade -y
sudo yum install -y python3-pip git wget yum-utils
pip3 install --user --upgrade pip