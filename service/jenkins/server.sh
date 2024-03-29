#!/usr/bin/env bash
sudo firewall-cmd --permanent --add-service=jenkins
sudo firewall-cmd --reload

docker run -d --restart always -p 8080:8080 -p 50000:50000 -v /var/jenkins_home --name jenkins jenkins/jenkins:lts