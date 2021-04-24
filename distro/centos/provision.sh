#!/usr/bin/env bash
# sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
# sudo curl -o /etc/yum.repos.d/CentOS-Base.repo https://mirrors.tencent.com/repo/centos7_base.repo
sudo yum update -y
sudo yum upgrade -y
sudo yum install -y python3-pip git wget yum-utils
pip3 install --user --upgrade pip
# pip3 install --user --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple