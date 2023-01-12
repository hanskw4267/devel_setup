#! /usr/bin/env bash

#
# pyenv_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install & config pyenv
#  
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install pyenv??" ; then
  echo "Installing pyenv"

  print_msg "Installing pyenv dependencies"
  sudo apt install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

  export PYENV_ROOT=$HOME/.pyenv
  export PATH=$PYENV_ROOT/bin:$PATH

  sed -Ei -e '/^([^#]|$)/ {a \
  export PYENV_ROOT="$HOME/.pyenv"
  a \
  export PATH="$PYENV_ROOT/bin:$PATH"
  a \
  ' -e ':a' -e '$!{n;ba};}' ~/.profile
  echo 'eval "$(pyenv init --path)"' >>~/.profile
  echo 'eval "$(pyenv init -)"' >> ~/.bashrc

  source ~/.profile
  source ~/.bashrc

  curl https://pyenv.run | bash
  pyenv update

else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping Pyenv"
fi