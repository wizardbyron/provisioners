#!/usr/bin/env bash


# Setup firewalld for k8s
function setup_firewalld(){
    echo "Setting up firewalld for k8s, refer to https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/"
    sudo firewall-cmd --zone=public --permanent --add-port=179/tcp # For Calico BGP
    sudo firewall-cmd --zone=public --permanent --add-port=2379-2380/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=6443/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=8000/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=10250-10252/tcp
    sudo firewall-cmd --reload
    return $?
}

function setup_flannel(){
    echo "Install and configure flannel"
    curl -o ./configs/kube-flannel.yml https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
    sed -i 's/- --kube-subnet-mgr$/- --kube-subnet-mgr\n        - --iface=eth1/' ./configs/kube-flannel.yml
    sed -i 's/10.244.0.0\/16/192.168.0.0\/16/' ./configs/kube-flannel.yml
    kubectl create -f ./configs/kube-flannel.yml
    return $?
}

function setup_calico(){
    echo "Install and configure calico"
    curl -o ./configs/calico.yaml https://docs.projectcalico.org/manifests/calico.yaml
    sed -i 's/# - name: CALICO_IPV4POOL_CIDR/- name: CALICO_IPV4POOL_CIDR/' ./configs/calico.yaml
    sed -i 's/#   value: "192.168.0.0\/16"/  value: "192.168.0.0\/16"/' ./configs/calico.yaml
    kubectl apply -f ./configs/calico.yaml
    return $?
}

# Initial k8s master cluster
function setup_control_panel(){
    CONTROL_PANEL_IP=$1
    K8S_IMAGE_REPO=$2
    echo "Setup Kubernetes Control Panel, IP: $CONTROL_PANEL_IP, Image Ropo: $K8S_IMAGE_REPO"
    sudo sh -c "echo '$(hostname -i) k8scp' >> /etc/hosts"
    if [ "$K8S_IMAGE_REPO" = "aliyun" ];then
        K8S_IMAGE_REPO_URL="registry.aliyuncs.com/google_containers"
    elif [ "$K8S_IMAGE_REPO" = "azk8s" ];then
        K8S_IMAGE_REPO_URL="gcr.azk8s.cn/google_containers"
    else
        K8S_IMAGE_REPO_URL="k8s.gcr.io"
    fi

    sudo kubeadm init --v=5 \
        --image-repository=$K8S_IMAGE_REPO_URL \
        --apiserver-advertise-address=$CONTROL_PANEL_IP \
        --service-cidr=10.0.0.0/16 \
        --pod-network-cidr=192.168.0.0/16

    if [ $? = 0 ]; then
        sudo sed -i 's/- --port=0$/#- --port=0/' /etc/kubernetes/manifests/kube-controller-manager.yaml
        sudo sed -i 's/- --port=0$/#- –-port=0/' /etc/kubernetes/manifests/kube-scheduler.yaml

        echo "Setting up kubectl for $(whoami)"
        mkdir -p $HOME/.kube
        sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
        sudo chown $(id -u):$(id -g) $HOME/.kube/config
    else
        exit 1
    fi
}

function share_public_info(){
    echo "Create a local http server to share the cluster join script"
    mkdir $HOME/public-info
    echo "$(kubeadm token create --print-join-command --ttl 0) --v=5" > $HOME/public-info/join-cluster.sh
    sudo docker run -d -p 8000:80 --restart always --name public-info --volume $HOME/public-info:/usr/share/nginx/html:ro nginx:alpine
    if [ $? = 0 ]; then
        sleep 5
        echo "$(curl http://$CONTROL_PANEL_IP:8000/join-cluster.sh)"
    else
        exit 1
    fi
    return $?
}


setup_firewalld
setup_control_panel $1 $2
setup_calico
share_public_info

# Install helm
echo "Install helm"
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

