#!/usr/bin/env bash
echo "Getting join-cluster.sh from $1"
curl -fsSL http://$1:8000/join-cluster.sh | sudo bash
