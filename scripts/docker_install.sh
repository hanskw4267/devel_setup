#! /usr/bin/env bash

#
# docker_install.sh
#
# Created on Tue Oct 05 2021 16:43:59
#
# Description:
# Script to install docker and docker compose
#   
# Copyright (c) 2021 Hans Kurnia
#

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install docker(-compose)??" ; then
print_msg 'Installing docker & docker-compose' 
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

docker-compose --version
print_msg "Trying hello-world image"
sudo docker run hello-world
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping docker(-compose)"
fi

print_msg "docker(-compose) install done :D"