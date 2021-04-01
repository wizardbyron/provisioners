#!/usr/bin/env bash
echo "sudo swapoff -a">>$HOME/.bashrc
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
