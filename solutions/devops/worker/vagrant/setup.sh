#!/usr/bin/env bash
echo "Install and upgrade Jenkins via package manager."
if [ -n "$(command -v yum)" ];then # for centos
sudo yum install -y java-11-openjdk
elif [ -n "$(command -v apt)" ];then # ubuntu
sudo apt-get install -y openjdk-11-jdk
else
echo "Your Linux package manager hasn't support"
exit 1
fi