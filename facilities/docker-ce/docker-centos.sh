#!/usr/bin/env bash
sudo yum install -y wget git
curl -fsSL https://get.docker.com |sudo sh
sudo usermod -aG docker vagrant
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker
