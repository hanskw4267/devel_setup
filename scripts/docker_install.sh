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

if os_check ; then
    exit 255
else
  if 64b_check ; then
    :
  else
    exit 255
  fi
fi
# ------------------------------------------------------------------------------

accept_all "docker & docker-compose"

if ask_user "Do you wish to install docker??" ; then
  echo 'Installing docker' 
  sudo apt remove docker docker-engine docker.io containerd runc
  sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt update
  sudo apt install -y docker-ce docker-ce-cli containerd.io
  sudo usermod -aG docker ${USER}

  print_msg "Trying hello-world image"
  sudo docker run hello-world
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping Docker"
fi

if ask_user "Do you wish to install docker compose??" ; then
  echo 'installing docker compose' 
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping Docker-compose"
fi

print_msg "Docker (compose) install done :D"
