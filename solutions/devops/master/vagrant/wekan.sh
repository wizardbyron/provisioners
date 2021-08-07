#!/usr/bin/env bash
echo "Install wekan. Port:2000"
sudo docker run -d --restart=always --name wekan-db mongo:4.4
sudo docker run -d --restart=always --name wekan --link "wekan-db:db" -e "WITH_API=true" -e "MONGO_URL=mongodb://wekan-db:27017/wekan" -e "ROOT_URL=http://$CLUSTER_IP:2000" -p 2000:8080 wekanteam/wekan:v5.41
