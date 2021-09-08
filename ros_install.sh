#! /usr/bin/env bash
# ROS install

onlyroot="Do not run this script as root!!!"

if [ $(whoami) == "root" ]; then     #"guarding against root execution"
    echo -e $COLOR$onlyroot$MONO
    exit 0
fi

echo "-------------------------------------------------"
echo "<-- ROS Setup - Hans -->"
echo "-------------------------------------------------"

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

echo "-------------------------------------------------"
echo " <-- Checking system version -->"
echo "-------------------------------------------------"

OS=""
VER=""
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

SYS_CHECK_OK=0
if [[ "$VER" == "${verArray[$ROS_DISTRO]}"*  ]] && [[ "$OS" == "Ubuntu" ]] ; then
    SYS_CHECK_OK=1
    echo " <-- SYSTEM VERSION CHECK OK -->"
    echo "-------------------------------------------------"
else
    read -r -p " Your system is not Ubuntu "${verArray[$ROS_DISTRO]}".XX, continue to install anyways? [y/N]" reply
    case "$reply" in
      [yY][eE][sS]|[yY] )
        SYS_CHECK_OK=1;
        echo " <-- SYSTEM VERSION CHECK FAILED BUT CONTINUING -->"
        ;;
      * )
        SYS_CHECK_OK=0
        echo " <-- SYSTEM VERSION CHECK FAILED -->"
        return 1
        ;;
    esac
fi

if [[ "$SYS_CHECK_OK" == 0 ]]; then
    return 1
fi

echo "<-- Updating base system -->"
sudo apt update
sudo apt upgrade -y

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
  
echo " Chosen ROS distro:"${ROS_DISTRO}" config:"${ROS_CONFIG}""

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

echo "-------------------------------------------------"
read -r -p " Add ROS "${ROS_DISTRO}" setup.bash sourcing to bashrc?? [y/N]" reply
case "$reply" in
  [yY][eE][sS]|[yY] )
      echo "# ROS "${ROS_DISTRO}" sourcing" >> ~/.bashrc
      echo "source /opt/ros/"${ROS_DISTRO}"/setup.bash" >> ~/.bashrc
      echo "Do check the sourcing was applied after this"
      ;;
  * )
      echo "Okay, no problem. :) Let's move on!"
      echo "Skipping sourcing"
      ;;
esac

echo "-------------------------------------------------"
read -r -p " Install and init rosdep?? [y/N]" reply
case "$reply" in
  [yY][eE][sS]|[yY] )
      echo "Install and initializing rosdep!!"
      sudo apt install -y python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
      sudo rosdep init
      rosdep update
      ;;
  * )
      echo "Okay, no problem. :) Let's move on!"
      echo "Skipping rosdep"
      ;;
esac

echo "-------------------------------------------------"
read -r -p " Install and init catkin tools?? [y/N]" reply
case "$reply" in
  [yY][eE][sS]|[yY] )
      echo "Installing catkin tools!!"
      sudo apt install -y python3-catkin-tools
      ;;
  * )
      echo "Okay, no problem. :) Let's move on!"
      echo "Skipping catkin tools"
      ;;
esac