#!/usr/bin/env bash
PATH=$PATH:/home/$(whoami)/.local/bin
rm -rf ./provisioners-master master.zip
wget https://github.com/wizardbyron/provisioners/archive/refs/heads/master.zip
unzip master.zip
export CLUSTER_IP=$(cat /home/$(whoami)/CLUSTER_IP)
sh -c "./provisioners-master/facilities/k8s/install.sh"
sh -c "./provisioners-master/facilities/k8s/setup-worker.sh $CLUSTER_IP"