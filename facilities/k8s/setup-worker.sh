#!/usr/bin/env bash
echo "Setting up firewalld, refer to https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/"
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=10250/tcp
sudo firewall-cmd --permanent --add-port=30000-32767/tcp
sudo firewall-cmd --reload

echo "Getting join-cluster.sh from $1"
curl -fsSL http://$1:8000/join-cluster.sh | sudo bash
