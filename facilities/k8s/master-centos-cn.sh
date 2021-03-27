#!/usr/bin/env bash
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
exclude=kube*
EOF

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet

cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

sudo systemctl enable docker.service
sudo systemctl daemon-reload
sudo systemctl restart docker

cat <<EOF | sudo tee /etc/sysctl.conf 
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 0
EOF

sudo sysctl -p
sudo swapoff -a

sudo kubeadm init \
--apiserver-advertise-address=0.0.0.0 \
--service-cidr=10.0.0.0/16 \
--pod-network-cidr=10.0.0.0/16 \
--image-repository registry.aliyuncs.com/google_containers

sudo sed -i 's/- --port=0$/#- --port=0/' /etc/kubernetes/manifests/kube-controller-manager.yaml 
sudo sed -i 's/- --port=0$/#- –-port=0/' /etc/kubernetes/manifests/kube-scheduler.yaml 

