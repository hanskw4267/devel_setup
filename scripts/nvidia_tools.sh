#! /usr/bin/env bash

#
# nvidia_tools.sh
#
# Created on Mon Sep 05 2022 16:30:44
#
# Description:
#   
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------


if ask_user "Do you wish to install NVIDIA Container toolkit??" ; then

    if ! [ -x "$(command -v docker)" ]; then
      print_msg "Docker not detected, attempting install!!!"
      sleep 2
      ./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/docker_install.sh
    fi

    echo "Installing NVIDIA Container toolkit"

    distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

    sudo apt-get update && sudo apt-get install -y nvidia-docker2
    sudo systemctl restart docker
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping Nvidia Container toolkit"
fi