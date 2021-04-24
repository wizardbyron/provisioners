#!/usr/bin/env bash

# Initial k8s master cluster
sudo systemctl enable firewalld
sudo kubeadm init \
# --image-repository docker.mirrors.ustc.edu.cn/google-containers \
--apiserver-advertise-address=0.0.0.0 \
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

sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# Install Flannel
# Configure flannel
# curl -o kube-flannel.yml https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# sed -i.bak 's|"/opt/bin/flanneld",|"/opt/bin/flanneld", "--iface=enp0s8",|' kube-flannel.yml
# kubectl create -f kube-flannel.yml

# sudo systemctl daemon-reload
# sudo systemctl restart kubelet
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
fi