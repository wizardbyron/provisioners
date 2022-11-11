#!/usr/bin/env bash
SERVER_IP=$1
sleep 10
curl -I http://$SERVER_IP:3000
if [ "$?" -eq 0 ];then
    echo "OpenLDAP server admin ui installation success".
else
    echo "OpenLDAP server admin ui installation failed".
fi