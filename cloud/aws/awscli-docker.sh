#!/usr/bin/env bash
sudo docker pull amazon/aws-cli 
sudo rm -rf $HOME/.aws
mkdir $HOME/.aws
alias aws="docker run --rm -it -v $HOME/.aws:/root/.aws -v /vagrant:/vagrant amazon/aws-cli"