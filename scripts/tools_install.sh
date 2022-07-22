#! /usr/bin/env bash

#
# tools_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install & config tools
#  
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

accept_all "basic tools"

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
apt_install can-utils
apt_install software-properties-common
apt_install screen