#! /usr/bin/env bash

#
# wine_install.sh
#
# Created on Tue Oct 05 2021 16:46:04
#
# Description:
# Ubuntu wine install
#   
# Copyright (c) 2021 Hans Kurnia
#


source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

print_msg "WINE ubuntu install - Hans"

if os_check ; then
  exit 255
fi

if ask_user "This script will install wine from WineHQ, have you previously install wine from another source??" ; then
  echo " please remove any old installations before attempting to install using this script"
  exit 255
fi

# if both checks fail, exit
if 64b_check ; then
  if 32b_check ; then
    :
  else
    sudo dpkg --add-architecture i386
  fi
  echo "<-- System architecture ok -->"
else
  echo "<-- Unknown system architecture --> "
  exit 255
fi

# ------------------------------------------------------------------------------

print_msg "Installing WINE now"

if [[ "$VERSION_ID" == *"18"* ]] ; then
  echo "Ubuntu 18.xx detected adding additional FAudio apt server"
  wget https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/Release.key
  sudo apt-key add Release.key
  sudo add-apt-repository 'deb https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/xUbuntu_18.04/ ./'
  sudo apt update
  rm Release.key
fi

wget -nc https://dl.winehq.org/wine-builds/winehq.key
sudo apt-key add winehq.key
sudo add-apt-repository "deb https://dl.winehq.org/wine-builds/ubuntu/ "${UBUNTU_CODENAME}" main"
sudo apt update
sudo apt install -y --install-recommends winehq-stable
rm winehq.key

print_msg "WINE install done. Installed version"
wine --version