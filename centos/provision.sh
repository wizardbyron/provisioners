#!/usr/bin/env bash
yum update -y
yum upgrade -y 
yum install -y wget git
curl -fsSL https://get.docker.com |sh
usermod -aG docker vagrant
service docker start

