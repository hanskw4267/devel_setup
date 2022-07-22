#! /usr/bin/env bash

#
# git_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install & config git
#  
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install git??" ; then
  echo "Installing Git"
  sudo apt install -y git
  if ask_user "Do you wish to configure git GLOBALLY??" ; then
    echo "What username do you want to use for git?"
    read git_username
    git config --global user.name "$git_username"
    echo "-----------------------------------------"
    echo "What user email do you want to use for git?"
    read git_useremail
    git config --global user.email "$git_useremail"
    echo "Git config done"
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping Git config"
  fi
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping Git"
fi