#! /usr/bin/env bash

#
# ros_install.sh
#
# Created on Tue Oct 05 2021 16:44:48
#
# Description:
# ROS1 installation script
#
# Copyright (c) 2021 Hans Kurnia
#

source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

print_msg "ROS Install - Hans"

declare -A verArray=(["melodic"]="bionic" ["noetic"]="focal")
echo " Which distro of ROS to install??"
select reply in "melodic" "noetic"; do
    case $reply in
      melodic )
        ROS_DISTRO="melodic"
        break
        ;;
      noetic )
        ROS_DISTRO="noetic"
        break
        ;;
      * )
        echo "Invalid choice, try again!!"
        ;;
    esac
  done

if os_ver_check "${verArray[$ROS_DISTRO]}" ; then
    return 255
fi

echo "-------------------------------------------------"
echo " Which config of "${ROS_DISTRO}" to install??"
select reply in "base" "desktop" "desktop-full"; do
    case $reply in
      base )
        ROS_CONFIG="ros-base"
        break
        ;;
      desktop )
        ROS_CONFIG="desktop"
        break
        ;;
      desktop-full )
        ROS_CONFIG="desktop-full"
        break
        ;;
      * )
        echo "Invalid choice, try again!!"
        ;;
    esac
  done
  
print_msg " Chosen ROS distro: "${ROS_DISTRO}" config: "${ROS_CONFIG}""
# ------------------------------------------------------------------------------

print_msg "<-- Updating base system -->"
sudo apt update
sudo apt upgrade -y

accept_all

echo "-------------------------------------------------"
echo " <-- Installing ROS "${ROS_DISTRO}" -->"
echo "-------------------------------------------------"

echo " <-- Setting up apt servers --> "
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt install curl # if you haven't already installed curl
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
sudo apt update
sudo apt install -y ros-"${ROS_DISTRO}"-"${ROS_CONFIG}"
source /opt/ros/"${ROS_DISTRO}"/setup.bash

if ask_user " Add ROS "${ROS_DISTRO}" setup.bash sourcing to bashrc??" ; then
  echo "# ROS "${ROS_DISTRO}" sourcing" >> ~/.bashrc
  echo "source /opt/ros/"${ROS_DISTRO}"/setup.bash" >> ~/.bashrc
  echo "Do check the sourcing was applied after this"
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping sourcing"
fi

if ask_user " Install and init rosdep??" ; then
  echo "Install and initializing rosdep!!"
  
  # Python3 support in noetic
  if [[ "${ROS_DISTRO}" == "noetic" ]] ; then
    sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
  else
    sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
  fi

  # Only init if it has not already been done before
  if [ ! -e /etc/ros/rosdep/sources.list.d/20-default.list ]; then
    sudo rosdep init
  fi
  rosdep update
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping rosdep"
fi


if ask_user "Install and init catkin tools?? " ; then
  echo "Installing catkin tools!!"
  sudo apt install -y python3-catkin-tools
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping catkin tools"
fi

print_msg "cleaning with autoremove"
sudo apt autoremove

print_msg "ROS Install Done"