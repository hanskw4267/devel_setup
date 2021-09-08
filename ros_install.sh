#! /usr/bin/env bash
# ROS install

onlyroot="Do not run this script as root!!!"

if [ $(whoami) == "root" ]; then     #"guarding against root execution"
    echo -e $COLOR$onlyroot$MONO
    exit 0
fi
source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
# ------------------------------------------------------------------------------

print_msg "ROS Install - Hans"

declare -A verArray=([melodic]=18 [noetic]=20)
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

print_msg "Checking system version"

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
  
echo " Chosen ROS distro: "${ROS_DISTRO}" config: "${ROS_CONFIG}""
# ------------------------------------------------------------------------------

echo "<-- Updating base system -->"
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
  sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
  sudo rosdep init
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

print_msg "ROS Install Done"