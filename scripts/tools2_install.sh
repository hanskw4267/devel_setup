#! /usr/bin/env bash

#
# tools2_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install & config extra tools
#  
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

accept_all "extra tools"

print_msg "Installing extra tools"

apt_install "snapd"
apt_install "flameshot"
apt_install "baobab"
apt_install "ncdu"