#! /usr/bin/env bash

#
# virtualbox61_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install & config virtualbox 6.1
#  
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install VirtualBox??" ; then
  declare -A vb_packages=( ["6.1"]=virtualbox-6.1 ["7.1"]=virtualbox-7.1 )

  echo "Which VirtualBox version do you want to install?"
  select reply in "6.1" "7.1"; do
    if [[ -n "${reply}" ]]; then
      VB_VERSION=${reply}
      break
    fi
    echo "Invalid choice, try again!!"
  done

  echo "Installing VirtualBox ${VB_VERSION}"

  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox-2016.list
  wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg
  sudo apt -y update
  sudo apt -y install "${vb_packages[$VB_VERSION]}"
  sudo groupadd -f vboxusers
  sudo usermod -aG vboxusers ${USER}

else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping kicad"
fi
