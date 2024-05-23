#! /usr/bin/env bash

#
# kicad 6.0_install.sh
#
# Created on Fri Jul 22 2022 11:01:10
#
# Description:
# Script to install & config kicad 6.0
#  
# Copyright (c) 2022 Hans Kurnia
#
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

if ask_user "Do you wish to install KiCad??" ; then

echo " Which version of KiCad to install??"
select reply in "6.0" "7.0" "8.0"; do
    case $reply in
      6.0 )
        KICAD_VERSION="6.0"
        break
        ;;
      7.0 )
        KICAD_VERSION="7.0"
        break
        ;;
      8.0 )
        KICAD_VERSION="8.0"
        break
        ;;
      * )
        echo "Invalid choice, try again!!"
        ;;
    esac
  done

print_msg " Chosen KiCad version: "${KICAD_VERSION}""
  echo "Installing Kicad ${KICAD_VERSION}"

  sudo apt install -y software-properties-common
  sudo add-apt-repository --yes ppa:kicad/kicad-${KICAD_VERSION}-releases
  sudo apt update
  sudo apt install -y --install-recommends kicad=${KICAD_VERSION}*

else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping KiCad"
fi