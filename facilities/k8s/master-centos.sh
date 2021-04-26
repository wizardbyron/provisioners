#!/usr/bin/env bash

# Initial k8s master cluster
echo "Initilize Kubernetes Culster, IP: $1"
sudo kubeadm init \
    --apiserver-advertise-address=$1 \
    --service-cidr=10.0.0.0/16 \
    --pod-network-cidr=10.244.0.0/16 

if [ $? = 0 ]; then

sudo sed -i 's/- --port=0$/#- --port=0/' /etc/kubernetes/manifests/kube-controller-manager.yaml
sudo sed -i 's/- --port=0$/#- –-port=0/' /etc/kubernetes/manifests/kube-scheduler.yaml

echo "Setting up firewalld"
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-port=2379-2380/tcp
sudo firewall-cmd --permanent --add-port=6443-10255/tcp
sudo firewall-cmd --reload

echo "Setting up kubectl for $(whoami)"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "Install and configure flannel"
curl -o kube-flannel.yml https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sed -i 's/- --kube-subnet-mgr$/- --kube-subnet-mgr\n        - --iface=eth1/' kube-flannel.yml
kubectl create -f kube-flannel.yml

sudo systemctl daemon-reload
sudo systemctl restart kubelet
sudo systemctl restart docker

# Create a simple http server to share join-cluster command so that nodes can join the cluster.
echo "Create a local http server to share the join-cluster.sh"
mkdir $HOME/join-cluster
kubeadm token create --print-join-command > $HOME/join-cluster/join-cluster.sh
sudo chmod -R o+rX $HOME/join-cluster/
sudo docker container run -d -p 8000:80 --rm --name public-info --volume $HOME/join-cluster:/usr/share/nginx/html:ro nginx
fi
