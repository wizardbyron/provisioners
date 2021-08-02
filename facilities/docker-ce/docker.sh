#!/usr/bin/env bash
echo "Install docker-ce via official installation script."
curl -fsSL https://get.docker.com | sudo bash

if [ $? = 0 ]; then
sudo usermod -aG docker $(whoami)
sudo systemctl restart docker
fi
