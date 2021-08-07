#!/usr/bin/env bash
PATH=$PATH:/home/$(whoami)/.local/bin:
rm -rf ./provisioners-master master.zip
wget https://github.com/wizardbyron/provisioners/archive/refs/heads/master.zip
unzip master.zip