#!/usr/bin/env bash
PATH=$PATH:/home/$(whoami)/.local/bin
export CONTROL_PANEL_IP=$1
echo "CONTROL PANEL IP: $CONTROL_PANEL_IP"

IMAGE_REPO="aliyun" # <empty>/aliyun
KUBE_VERSION="1.23.0-0"
sh -c "/vagrant/facilities/k8s/install.sh $IMAGE_REPO $KUBE_VERSION"
sh -c "/vagrant/facilities/k8s/setup-worker-node.sh $CONTROL_PANEL_IP"