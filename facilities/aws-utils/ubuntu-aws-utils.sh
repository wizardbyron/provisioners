#!/bin/sh
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt install -y python-pip ansible awscli
sudo pip install --upgrade pip
sudo pip install boto
