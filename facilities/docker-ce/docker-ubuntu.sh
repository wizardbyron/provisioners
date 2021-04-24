#!/usr/bin/env bash
curl -fsSL https://get.docker.com | bash
 sudo usermod -aG docker $(whoami)