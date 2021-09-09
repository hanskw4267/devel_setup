#! /usr/bin/env bash

# Script to install docker and docker compose

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

print_msg "Docker (compose) Install - Hans"

if os_check ; then
    return 255
fi
# ------------------------------------------------------------------------------

echo "<-- Updating base system -->"
sudo apt update
sudo apt upgrade -y

accept_all

echo 'installing docker' 
sudo apt-get remove docker docker-engine docker.io
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
docker --version
chmod 777 /var/run/docker.sock
docker run hello-world

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