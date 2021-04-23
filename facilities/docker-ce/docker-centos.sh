#!/usr/bin/env bash
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# sudo sed -i 's+download.docker.com+mirrors.tuna.tsinghua.edu.cn/docker-ce+' /etc/yum.repos.d/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io makecache fast
sudo systemctl start docker
sudo usermod -aG docker vagrant
pip3 install --user docker-compose
# su - vagrant -c "pip3 install --user docker-compose -i https://pypi.tuna.tsinghua.edu.cn/simple"
