#! /usr/bin/env bash

#
# vscode_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install vscode
#  
# Copyright (c) 2022 Hans Kurnia
#

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install VSCode??" ; then
  echo "Installing VSCode"
  sudo apt install -y apt-transport-https gnome-keyring
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt update
  sudo apt install -y code
  code --version

  if ask_user "Do you wish to install some of my favourite VSCode extentions? (you can choose for each)" ; then
    echo "Installing VSCode extensions"
    accept_all "vscode extensions"
    code_install ms-vscode.cpptools-extension-pack
    code_install ms-python.python
    code_install ms-iot.vscode-ros
    code_install eamodio.gitlens
    code_install ms-vscode-remote.remote-ssh
    code_install mhutchie.git-graph
    code_install wayou.vscode-todo-highlight
    code_install oderwat.indent-rainbow
    code_install pkief.material-icon-theme
    code_install esbenp.prettier-vscode
    code_install redhat.vscode-yaml
    code_install doi.fileheadercomment
    code_install akiramiyakoda.cppincludeguard

  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping VSCode extensions"
  fi
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping VSCode"
fi