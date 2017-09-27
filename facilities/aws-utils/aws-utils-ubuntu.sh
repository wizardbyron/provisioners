#!/bin/sh
sudo apt update
sudo apt dist-upgrade -y

# Add repositories
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update

# Install packages via apt
sudo apt install -y python-pip ansible awscli

# Install packages via pip
sudo pip install --upgrade pip
sudo pip install boto
