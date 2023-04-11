#! /usr/bin/env bash

#
# extra_apps.sh
#
# Created on Tue Apr 11 2023 12:24:11
#
# Description:
#   
# Copyright (c) 2023 Hans Kurnia
#

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

accept_all "extra communication & entertainment apps"

print_msg "Installing communication & entertainment apps"

snap_install "spotify"
snap_install "slack --classic"
snap_install "telegram-desktop"
snap_install "discord"
snap_install "teams"