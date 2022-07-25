#! /usr/bin/env bash

#
# chrome_install.sh
#
# Created on Fri Jul 22 2022 11:12:22
#
# Description:
# Script to install the google chrome browser
#   
# Copyright (c) 2022 Hans Kurnia
#

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install google chrome??" ; then
  echo "Installing chrome"
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install ./google-chrome-stable_current_amd64.deb
  rm ./google-chrome-stable_current_amd64.deb
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping google chrome"
fi