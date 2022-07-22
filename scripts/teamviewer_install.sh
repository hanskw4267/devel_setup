#! /usr/bin/env bash

#
# teamviewer_install.sh
#
# Created on Fri Jul 22 2022 11:12:22
#
# Description:
# Script to install teamviewer software
#   
# Copyright (c) 2022 Hans Kurnia
#

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install teamviewer??" ; then
  echo "Installing teamviewer"
  wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
  sudo apt install ./teamviewer_amd64.deb
  rm ./teamviewer_amd64.deb
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping teamviewer"
fi