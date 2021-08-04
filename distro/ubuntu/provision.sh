#!/usr/bin/env bash
sudo apt update -y
sudo apt dist-upgrade -y
sudo apt install -y software-properties-common git python3-pip firewalld
pip install -U pip