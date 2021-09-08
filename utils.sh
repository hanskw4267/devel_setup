#! /usr/bin/env bash

# Utility functions for the other scripts

ask_user () {
  echo "-------------------------------------------------"
  if [[ "$ACCEPT_ALL" == 0 ]] ; then
    true
  else
    read -r -p "$1 [y/N]" reply
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
  if ask_user "Accept all future prompts?? (i.e. attempt install EVERYTHING, please check if this is what you want)" ; then
  ACCEPT_ALL=0
  export ACCEPT_ALL
  fi
}

apt_install () {
  if ask_user "Do you wish to install "${1}"?? "; then
    echo "Installing "$1""
    sudo apt install -y $1
    if [ $? -eq 0 ]; then
      echo "<--------------------------- $1 Install OK"
    else
      echo "<--------------------------- $1 Install failed"
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
      echo "<--------------------------- $1 Install OK"
    else
      echo "<--------------------------- $1 Install failed"
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
      echo "<--------------------------- $1 Install OK"
    else
      echo "<--------------------------- $1 Install failed"
      exit $?
    fi
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping $1"
  fi
}

source_os () {
  NAME=""
  if [ -f /etc/os-release ]; then
      source /etc/os-release
  fi
}

os_check () {
  source_os
  if [[ "$NAME" == "Ubuntu" ]] ; then
    echo " <-- SYSTEM VERSION CHECK OK --> "
    false
  else
    read -r -p " Your system is not Ubuntu, continue to setup anyways? [y/N]" reply
    case "$reply" in
      [yY][eE][sS]|[yY] )
        echo " <-- SYSTEM VERSION CHECK FAILED BUT CONTINUING --> "
        false
        ;;
      * )
        echo " <-- SYSTEM VERSION CHECK FAILED --> "
        true
        ;;
    esac
  fi
}

os_ver_check() {
  source_os
  if [[ "$NAME" == "Ubuntu" ]] && [[ "$VERSION_ID" == "$1"* ]] ; then
    echo " <-- SYSTEM VERSION CHECK OK --> "
    false
  else
    read -r -p " Your system is not Ubuntu "$1".XX, continue to setup anyways? [y/N]" reply
    case "$reply" in
      [yY][eE][sS]|[yY] )
        echo " <-- SYSTEM VERSION CHECK FAILED BUT CONTINUING --> "
        false
        ;;
      * )
        echo " <-- SYSTEM VERSION CHECK FAILED --> "
        true
        ;;
    esac
  fi
}

print_msg() {
  echo "-------------------------------------------------"
  echo "<-- "$1" -->"
  echo "-------------------------------------------------"
}