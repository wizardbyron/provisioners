#!/usr/bin/env bash
yum update -y
curl -fsSL https://get.docker.com |sh
usermod -aG docker vagrant
