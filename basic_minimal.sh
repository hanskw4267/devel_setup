#! /usr/bin/env bash

#
# basic_minimal.sh
#
# Created on Tue Oct 05 2021 16:43:35
#
# Description:
# Post install script to setup a linux development environment
#  
# Copyright (c) 2021 Hans Kurnia
#
BASEDIR=$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")
source ${BASEDIR}/scripts/utils.sh
root_guard
# ------------------------------------------------------------------------------

print_msg "Basic Development Setup - Hans"

if os_check ; then
    exit 255
fi
# ------------------------------------------------------------------------------

if ask_user "Update/Upgrade system first?" ; then
  print_msg "Updating base system"
  sudo apt update
  sudo apt upgrade -y
fi

./${BASEDIR}/scripts/tools_install.sh
./${BASEDIR}/scripts/git_install.sh
./${BASEDIR}/scripts/vscode_install.sh

if ask_user "Do you wish to add my aliases to bashrc??" ; then
  echo "#My own aliases----" >> ~/.bashrc
  echo "alias uupgrade=\"sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove\"" >> ~/.bashrc
  echo "alias git=\"git \"" >> ~/.bashrc
  echo "alias code=\"code \"" >> ~/.bashrc
  echo "alias clone=\"clone --recursive\"" >> ~/.bashrc
  echo "alias cd=\"cd \"" >> ~/.bashrc
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping aliases"
fi

print_msg "cleaning with autoremove"
sudo apt autoremove -y

print_msg "Minimal Basic Development Setup Done :D"
