#! /usr/bin/env bash

# Script to install docker and docker compose

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

print_msg "Docker (compose) Install - Hans"

if os_check ; then
    return 255
else
  if 64b_check ; then
    :
  else
    return 255
  fi
fi
# ------------------------------------------------------------------------------

print_msg "<-- Updating base system -->"
sudo apt update
sudo apt upgrade -y

accept_all

print_msg 'Installing docker' 
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

print_msg "Trying hello-world image"
sudo docker run hello-world

if ask_user "Do you wish to install docker compose??" ; then
  echo 'installing docker compose' 
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  docker-compose --version
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping Docker"
fi

print_msg "Docker (compose) install done :D"