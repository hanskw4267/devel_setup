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

BASEDIR=$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")
source ${BASEDIR}/scripts/utils.sh
root_guard
# ------------------------------------------------------------------------------

./${BASEDIR}/basic_minimal.sh

ret=$?
if [[ "${ret}" -ne 0 ]] ; then
  exit 255
fi

./${BASEDIR}/scripts/tools2_install.sh
./${BASEDIR}/scripts/docker_install.sh
./${BASEDIR}/scripts/chrome_install.sh
./${BASEDIR}/scripts/teamviewer_install.sh
./${BASEDIR}/scripts/zoom_install.sh
./${BASEDIR}/scripts/pyenv_install.sh
./${BASEDIR}/scripts/kicad6_install.sh
./${BASEDIR}/scripts/virtualbox61_install.sh
./${BASEDIR}/scripts/extra_apps.sh

print_msg "cleaning with autoremove"
sudo apt autoremove -y

print_msg "Full Basic Development Setup Done :D"