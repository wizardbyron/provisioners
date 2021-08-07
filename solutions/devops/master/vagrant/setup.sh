#!/usr/bin/env bash
rm -rf ./provisioners
wget https://github.com/wizardbyron/provisioners/archive/refs/heads/master.zip
unzip master.zip
sh -c "./provisioners-master/solution/devops/jenkins.sh"

echo "Install wekan. Port:2000"
sudo docker run -d --restart=always --name wekan-db mongo:4.4
sudo docker run -d --restart=always --name wekan --link "wekan-db:db" -e "WITH_API=true" -e "MONGO_URL=mongodb://wekan-db:27017/wekan" -e "ROOT_URL=http://$CLUSTER_IP:2000" -p 2000:8080 wekanteam/wekan:v5.41

echo "Install nexus repository manager. Port:8081"
sudo docker volume create --name nexus-data
sudo docker run -d --restart=always -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3