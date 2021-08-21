#!/usr/bin/env bash
PATH=$PATH:/home/$(whoami)/.local/bin
export CLUSTER_IP=$2
echo "Cluster IP: $CLUSTER_IP"

rm -rf ./provisioners-master master.zip
wget https://github.com/wizardbyron/provisioners/archive/refs/heads/master.zip
unzip master.zip

sh -c "./provisioners-master/facilities/k8s/install.sh"
sh -c "./provisioners-master/facilities/k8s/setup-cluster.sh $CLUSTER_IP"