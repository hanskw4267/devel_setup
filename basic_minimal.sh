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

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

print_msg "Basic Development Setup - Hans"

if os_check ; then
    return 255
fi
# ------------------------------------------------------------------------------

print_msg "<-- Updating base system -->"
sudo apt update
sudo apt upgrade -y

accept_all

print_msg "Installing basic tools"
apt_install terminator
apt_install vim
apt_install nano
apt_install wget
apt_install curl
apt_install openssh-server
apt_install build-essential
apt_install cmake
apt_install python3-pip
apt_install net-tools
apt_install valgrind
apt_install htop
apt_install nmap

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

if ask_user "Do you wish to install VSCode??" ; then
  echo "Installing VSCode"
  sudo apt install -y apt-transport-https
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt update
  sudo apt install -y code
  code --version

  if ask_user "Do you wish to install some of my favourite VSCode extentions? (you can choose for each)" ; then
    echo "Installing VSCode extensions"
    code_install ms-vscode.cpptools-extension-pack
    code_install ms-python.python
    code_install ms-iot.vscode-ros
    code_install vscjava.vscode-java-pack

    code --disable-extensions
    
    code_install eamodio.gitlens
    code_install ms-vscode-remote.remote-ssh
    code_install coenraads.bracket-pair-colorizer-2
    code_install mhutchie.git-graph
    code_install wayou.vscode-todo-highlight
    code_install oderwat.indent-rainbow
    code_install pkief.material-icon-theme
    code_install esbenp.prettier-vscode
    code_install redhat.vscode-yaml
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping VSCode extensions"
  fi
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping VSCode"
fi

if ask_user "Do you wish to add my aliases to bashrc??" ; then
  echo "#My own aliases----" >> ~/.bashrc
  echo "alias uupgrade=\"sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove\"" >> ~/.bashrc
  echo "alias git=\"git \"" >> ~/.bashrc
  echo "alias clone=\"clone --recursive\"" >> ~/.bashrc
  echo "alias cd=\"cd \"" >> ~/.bashrc
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping aliases"
fi

print_msg "cleaning with autoremove"
sudo apt autoremove -y

print_msg "Minimal Basic Development Setup Done :D"
