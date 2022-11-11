#!/usr/bin/env bash
SERVER_IP=$1
sleep 60
curl -I http://$SERVER_IP:8080
if [ "$?" -eq 0 ];then
    echo "Jenkins server installation success".
else
    echo "Jenkins server installation failed".
fi