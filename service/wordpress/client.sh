#!/usr/bin/env bash
SERVER_IP=$1
sleep 10
curl -I http://$SERVER_IP
if [ "$?" -eq 0 ];then
    echo "Wordpress server installation success".
else
    echo "Wordpress server installation failed".
fi