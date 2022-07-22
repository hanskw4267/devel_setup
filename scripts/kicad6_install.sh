#! /usr/bin/env bash

#
# kicad 6.0_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install & config kicad 6.0
#  
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install kicad 6.0??" ; then
  echo "Installing kicad 6.0"

  sudo apt install -y software-properties-common
  sudo add-apt-repository --yes ppa:kicad/kicad-6.0-releases
  sudo apt update
  sudo apt install -y --install-recommends kicad

else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping kicad"
fi