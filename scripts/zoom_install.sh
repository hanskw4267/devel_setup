#! /usr/bin/env bash

#
# zoom_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install zoom software
#  
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install zoom (amd64)??" ; then
  echo "Installing zoom"
  wget https://zoom.us/client/latest/zoom_amd64.deb
  sudo apt install -y ./zoom_amd64.deb
  rm ./zoom_amd64.deb
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping zoom"
fi