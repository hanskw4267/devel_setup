#! /usr/bin/env bash

#
# ros2_install.sh
#
# Created on Tue Oct 05 2021 16:45:14
#
# Description:
# ROS2 Installation script
#
# Copyright (c) 2021 Hans Kurnia
#


source $(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")/utils.sh
root_guard
# ------------------------------------------------------------------------------

print_msg "ROS2 Install - Hans"

declare -A verArray=(["dashing"]="bionic" ["foxy"]="focal" ["galactic"]="focal" ["humble"]="jammy" ["iron"]="jammy" ["jazzy"]="noble" )
echo " Which version of ROS2 to install??"
select reply in "dashing" "foxy" "galactic" "humble" "iron" "jazzy"; do
    case $reply in
      dashing )
        ROS_DISTRO="dashing"
        break
        ;;
      foxy )
        ROS_DISTRO="foxy"
        break
        ;;
      galactic )
        ROS_DISTRO="galactic"
        break
        ;;
      humble )
        ROS_DISTRO="humble"
        break
        ;;
      iron )
        ROS_DISTRO="iron"
        break
        ;;
      jazzy )
        ROS_DISTRO="jazzy"
        break
        ;;
      * )
        echo "Invalid choice, try again!!"
        ;;
    esac
  done

if os_ver_check "${verArray[$ROS_DISTRO]}" ; then
    exit 255
fi

echo "-------------------------------------------------"
echo " Which config of "${ROS_DISTRO}" to install??"
select reply in "base" "desktop"; do
    case $reply in
      base )
        ROS_CONFIG="ros-base"
        break
        ;;
      desktop )
        ROS_CONFIG="desktop"
        break
        ;;
      * )
        echo "Invalid choice, try again!!"
        ;;
    esac
  done

print_msg " Chosen ROS distro:"${ROS_DISTRO}" config:"${ROS_CONFIG}""
# ------------------------------------------------------------------------------
accept_all "ros2 & colcon & rosdep"

print_msg "Installing ROS2 "${ROS_DISTRO}""

echo " <--- Setting apt server --> "
sudo apt update && sudo apt install -y curl gnupg gnupg2 lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

echo " <-- Installing ROS2 --> "
sudo apt update
sudo apt install -y ros-dev-tools
sudo apt install -y ros-"${ROS_DISTRO}"-"${ROS_CONFIG}"

if ask_user "Add ROS2 "${ROS_DISTRO}" setup.bash sourcing to bashrc??" ; then
  echo "# ROS2 "${ROS_DISTRO}" sourcing" >> ~/.bashrc
  echo "source /opt/ros/"${ROS_DISTRO}"/setup.bash" >> ~/.bashrc
  echo "Do check the sourcing was applied after this"
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping sourcing"
fi

if ask_user "Do you wish to install colcon??" ; then
  sudo sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
  curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
  sudo apt update
  sudo apt install -y python3-colcon-common-extensions
  echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
  echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc
  echo "Refer to https://docs.ros.org/en/"${ROS_DISTRO}"/Tutorials/Configuring-ROS2-Environment.html to configure colcon"
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping colcon"
fi

if ask_user " Install and init rosdep??" ; then
  echo "Install and initializing rosdep!!"
  
  sudo apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential

  # Only init if it has not already been done before
  if [ ! -e /etc/ros/rosdep/sources.list.d/20-default.list ]; then
    sudo rosdep init
  fi
  rosdep update
  echo "alias rosdep_install=\"rosdep install --ignore-src --from-paths src -r -y \"" >> ~/.bashrc
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping rosdep"
fi

print_msg "ROS2 Install Done"
