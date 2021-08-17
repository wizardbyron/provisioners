#!/usr/bin/env bash
echo "Install and upgrade Jenkins via package manager."
if [ -n "$(command -v yum)" ];then # for centos
sudo yum install -y java-11-openjdk
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install -y jenkins
sudo service jenkins start
elif [ -n "$(command -v apt)" ];then # ubuntu
sudo apt-get install -y openjdk-11-jdk
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins
else
echo "Your Linux package manager hasn't support"
exit 1
fi

sudo cp /var/lib/jenkins/secrets/initialAdminPassword $HOME/jenkinsInitPassword
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
