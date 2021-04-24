#!/usr/bin/env bash
sudo docker pull amazon/aws-cli 
mkdir $HOME/.aws
echo "alias aws=\"docker run --rm -it -v $HOME/.aws:/root/.aws amazon/aws-cli\"" >> $HOME/.bashrc
