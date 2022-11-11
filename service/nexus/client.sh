#!/usr/bin/env bash
SERVER_IP=$1
sleep 60
curl -I http://$SERVER_IP:8081
if [ "$?" -eq 0 ];then
    echo "Nexus server installation success".
else
    echo "Nexus server installation failed".
fi