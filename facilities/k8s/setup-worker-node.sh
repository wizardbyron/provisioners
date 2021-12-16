#!/usr/bin/env bash
echo "Setting up firewalld, refer to https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/"
sudo firewall-cmd --permanent --add-port=179/tcp # For Calico BGP
sudo firewall-cmd --permanent --add-port=10250/tcp
sudo firewall-cmd --permanent --add-port=30000-32767/tcp
sudo firewall-cmd --reload

CONTROL_PANEL_IP=$1
echo "Getting join-cluster.sh from $CONTROL_PANEL_IP"
curl -fsSL http://$CONTROL_PANEL_IP:8000/join-cluster.sh | sudo bash
