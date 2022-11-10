#!/usr/bin/env bash

# Update docker settings
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

sudo systemctl enable --now docker.service
sudo systemctl restart docker

# Setup Network and firewall
cat <<EOF | sudo tee /etc/sysctl.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-arptables = 0
EOF
sudo sysctl -p

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

# Switch off swap
sudo swapoff -a
echo "sudo swapoff -a">>$HOME/.bashrc

echo "Install Kubernetes packages via package manager."

KUBE_VERSION=$1
PACKAGE_MIRROR=$2
if [ $PACKAGE_MIRROR = "aliyun" ];then
    PACKAGE_URL=mirrors.aliyun.com/kubernetes
else
    PACKAGE_URL=packages.cloud.google.com
fi


if [ -n "$(command -v yum)" ];then # for centos
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://$PACKAGE_URL/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://$PACKAGE_URL/yum/doc/yum-key.gpg https://$PACKAGE_URL/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

# Set SELinux in permissive mode (effectively disabling it)
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sh -c "sudo yum install -y kubelet-$KUBE_VERSION kubeadm-$KUBE_VERSION kubectl-$KUBE_VERSION --disableexcludes=kubernetes"

elif [ -n "$(command -v apt)" ];then # ubuntu
  sudo apt update
  sudo apt install -y apt-transport-https ca-certificates curl
  curl https://$PACKAGE_URL/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://$PACKAGE_URL/apt/ kubernetes-xenial main"|sudo tee /etc/apt/sources.list.d/kubernetes.list
  sudo apt update
  ZERO=0
  sh -c "sudo apt install -y kubelet=$KUBE_VERSION$ZERO kubeadm=$KUBE_VERSION$ZERO kubectl=$KUBE_VERSION$ZERO"
  sudo apt-mark hold kubelet kubeadm kubectl
else
  echo "Your Linux package manager doesn't support"
  exit 1
fi

sudo systemctl enable --now kubelet