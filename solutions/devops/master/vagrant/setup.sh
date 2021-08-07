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

echo "Install wekan. Port:2000"
sudo docker run -d --restart=always --name wekan-db mongo:4.4
sudo docker run -d --restart=always --name wekan --link "wekan-db:db" -e "WITH_API=true" -e "MONGO_URL=mongodb://wekan-db:27017/wekan" -e "ROOT_URL=http://$CLUSTER_IP:2000" -p 2000:8080 wekanteam/wekan:v5.41

echo "Install nexus repository manager. Port:8081"
sudo docker volume create --name nexus-data
sudo docker run -d --restart=always -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3