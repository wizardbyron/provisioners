#!/usr/bin/env bash
echo "Install nexus repository manager. Port:8081"
sudo docker volume create --name nexus-data
sudo docker run -d --restart=always -p 8081:8081 --name nexus -v nexus-data:/nexus-data sonatype/nexus3