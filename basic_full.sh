#! /usr/bin/env bash

#
# basic_full.sh
#
# Created on Tue Oct 05 2021 16:42:48
#
# Description:
# Post install script to setup a linux development environment
#   
# Copyright (c) 2021 Hans Kurnia
#

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/scripts/utils.sh
root_guard
# ------------------------------------------------------------------------------

./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/basic_minimal.sh

ret=$?
if [[ "${ret}" -ne 0 ]] ; then
  exit 255
fi

./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/scripts/tools2_install.sh
./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/scripts/chrome_install.sh
./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/scripts/teamviewer_install.sh
./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/scripts/zoom_install.sh
./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/scripts/pyenv_install.sh
./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/scripts/kicad6_install.sh
./$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/scripts/virtualbox61_install.sh

print_msg "cleaning with autoremove"
sudo apt autoremove -y

print_msg "Full Basic Development Setup Done :D"