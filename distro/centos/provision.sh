#!/usr/bin/env bash
sudo yum update -y
sudo yum upgrade -y
sudo yum install -y python3-pip git wget yum-utils
sudo su vagrant -c "pip3 install --user --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple"
