#!/usr/bin/env bash
PATH=$PATH:/home/$(whoami)/.local/bin
rm -rf ./provisioners-master master.zip
wget https://github.com/wizardbyron/provisioners/archive/refs/heads/master.zip
unzip master.zip
sh -c "./provisioners-master/facilities/jenkins.sh"
sh -c "./provisioners-master/facilities/wekan.sh"
sh -c "./provisioners-master/facilities/nexus.sh"
docker-compose -f ./provisioners-master/facilities/gitea/docker-compose.yml up