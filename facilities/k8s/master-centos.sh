#!/usr/bin/env bash

# Initial k8s master cluster
sudo kubeadm init \
    --apiserver-advertise-address=$2 \
    --service-cidr=10.0.0.0/16 \
    --pod-network-cidr=10.244.0.0/16 

if [ $? = 0 ]; then

sudo sed -i 's/- --port=0$/#- --port=0/' /etc/kubernetes/manifests/kube-controller-manager.yaml
sudo sed -i 's/- --port=0$/#- –-port=0/' /etc/kubernetes/manifests/kube-scheduler.yaml

sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=2379-2380/tcp
sudo firewall-cmd --permanent --add-port=6443-10255/tcp
sudo firewall-cmd --reload

sudo sh -c "export KUBECONFIG=/etc/kubernetes/admin.conf"
sudo sh -c "echo 'export KUBECONFIG=/etc/kubernetes/admin.conf'>>/root/.bashrc"

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# Install and configure flannel
curl -o kube-flannel.yml https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sed -i 's/- --kube-subnet-mgr$/- --kube-subnet-mgr\n        - --iface=eth1/' kube-flannel.yml
kubectl create -f kube-flannel.yml

sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Create a simple http server to share join-cluster command so that nodes can join the cluster.
kubeadm token create --print-join-command > $HOME/join-cluster.sh
fi
