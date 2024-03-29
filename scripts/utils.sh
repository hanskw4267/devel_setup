#! /usr/bin/env bash

#
# utils.sh
#
# Created on Tue Oct 05 2021 16:45:27
#
# Description:
# Utility functions for the other scripts
#   
# Copyright (c) 2021 Hans Kurnia
#

onlyroot="Do not run this script as root!!!"
root_guard() {
  if [ $(whoami) == "root" ]; then     #"guarding against root execution"
      echo -e $COLOR$onlyroot$MONO
      exit 0
  fi
}

print_msg() {
  echo "-------------------------------------------------"
  echo -e "<-- "$1" -->"
  echo "-------------------------------------------------"
}

ask_user () {
  if [[ "$ACCEPT_ALL" == 0 ]] ; then
    true
  else
    read -r -p "$1 [y/N] " reply
    case "$reply" in
      [yY][eE][sS]|[yY] )
        true
        ;;
      * ) 
        false
        ;;
    esac
  fi
}

accept_all () {
  export ACCEPT_ALL=1
  if ask_user "Accept all future prompts for ${1}?? (i.e. attempt install EVERYTHING, please check if this is what you want)" ; then
  ACCEPT_ALL=0
  export ACCEPT_ALL
  fi
}

apt_install () {
  if ask_user "Do you wish to install "${1}"?? "; then
    echo "Installing "$1""
    sudo apt install -y $1
    if [ $? -eq 0 ]; then
      print_msg "$1 Install OK"
    else
      print_msg "$1 Install failed"
      exit $?
    fi
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping $1"
  fi
}

code_install () {
  if ask_user "Do you wish to install the extension "${1}"?? "; then
    echo "Installing "$1""
    code --install-extension $1
    if [ $? -eq 0 ]; then
      print_msg "$1 Install OK"
    else
      print_msg "$1 Install failed"
      exit $?
    fi
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping $1"
  fi
}

snap_install () {
  if ask_user "Do you wish to install "${1}"?? Make SURE you have snap store installed?? "; then
    echo "Installing "$1""
    sudo snap install $1
    if [ $? -eq 0 ]; then
      print_msg "$1 Install OK"
    else
      print_msg "$1 Install failed"
      exit $?
    fi
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping $1"
  fi
}

source_os () {
  NAME=""
  if [ -f /etc/os-release ]; then # try os-release
    source /etc/os-release
  else  # try lsb_release
    NAME=$(lsb_release -si) 
    VERSION_ID=$(lsb_release -sr)
    VERSION_CODENAME=$(lsb_release -sc)
    PRETTY_NAME=$(lsb_release -sd)
  fi

  echo "Detected system:"
  echo "OS Name: "${PRETTY_NAME}""
  echo -e "OS Codename: "${VERSION_CODENAME}"\n"
}

os_check () {
  print_msg "Checking system version"
  source_os
  if [[ "$NAME" == "Ubuntu" ]] ; then
    print_msg " SYSTEM VERSION CHECK OK "
    false
  else
    read -r -p " Your system is not Ubuntu, continue to setup anyways? [y/N]" reply
    case "$reply" in
      [yY][eE][sS]|[yY] )
        print_msg " SYSTEM VERSION CHECK FAILED BUT CONTINUING "
        false
        ;;
      * )
        print_msg " SYSTEM VERSION CHECK FAILED "
        true
        ;;
    esac
  fi
}

os_ver_check() {
  print_msg "Checking system version"
  source_os
  echo "Recommended OS: $1"
  if [[ "$NAME" == "Ubuntu" ]] && [[ "$VERSION_CODENAME" == "$1" ]] ; then
    print_msg " SYSTEM VERSION CHECK OK "
    false
  else
    read -r -p "Your system is not Ubuntu "$1", continue to setup anyways? [y/N]" reply
    case "$reply" in
      [yY][eE][sS]|[yY] )
        print_msg " SYSTEM VERSION CHECK FAILED BUT CONTINUING "
        false
        ;;
      * )
        print_msg " SYSTEM VERSION CHECK FAILED "
        true
        ;;
    esac
  fi
}

64b_check() {
  print_msg "Checking system's architecture"
  if [[ "$(dpkg --print-architecture)" == "amd64" ]] ; then
    true
  else
    echo "<-- Failed amd64 check -->"
    false
  fi
}

32b_check() {
  if [[ "$(dpkg --print-foreign-architectures)" == "i386" ]] ; then
    true
  else
    echo "<-- Failed i386 architecture check -->"
    false
  fi
}
