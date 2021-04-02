#!/usr/bin/env bash
mkdir wekan && curl -o wekan/docker-compose.yml  https://raw.githubusercontent.com/wekan/wekan/master/docker-compose.yml
cd wekan && docker-compose up -d
