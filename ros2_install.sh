#! /usr/bin/env bash
# ROS install

onlyroot="Do not run this script as root!!!"

if [ $(whoami) == "root" ]; then     #"guarding against root execution"
    echo -e $COLOR$onlyroot$MONO
    exit 0
fi

echo "-------------------------------------------------"
echo "<-- ROS2 Setup - Hans -->"
echo "-------------------------------------------------"

declare -A verArray=([dashing]=18 [foxy]=20 [galactic]=20)
echo " Which version of ROS2 to install??"
select reply in "dashing" "foxy" "galactic"; do
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
if [[ "$VER" == "${verArray[$ROS_DISTRO]}"* ]] && [[ "$OS" == "Ubuntu" ]] ; then
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
echo " Chosen ROS distro:"${ROS_DISTRO}" config:"${ROS_CONFIG}""

echo "-------------------------------------------------"
echo " <-- Installing ROS2 "${ROS_DISTRO}" -->"
echo "-------------------------------------------------"

echo " <--- Adding ROS2 apt server --> "
sudo apt update && sudo apt install -y curl gnupg gnupg2 lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

echo " <-- Installing ROS2 --> "
sudo apt update
sudo apt install -y ros-"${ROS_DISTRO}"-"${ROS_CONFIG}"

read -r -p " Add ROS2 "${ROS_DISTRO}" setup.bash sourcing to bashrc?? [y/N]" reply
  case "$reply" in
      [yY][eE][sS]|[yY] )
          echo "# ROS2 "${ROS_DISTRO}" sourcing" >> ~/.bashrc
          echo "source /opt/ros/"${ROS_DISTRO}"/setup.bash" >> ~/.bashrc
          echo "Do check the sourcing was applied after this"
          ;;
      * )
          echo "Okay, no problem. :) Let's move on!"
          echo "Skipping sourcing"
          ;;
    esac

echo "-------------------------------------------------"
read -r -p " Do you wish to install colcon?? [y/N]" reply
  case "$reply" in
      [yY][eE][sS]|[yY] )
        sudo sh -c 'echo "deb [arch=amd64,arm64] http://repo.ros2.org/ubuntu/main `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
        curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
        sudo apt update
        sudo apt install -y python3-colcon-common-extensions
        echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
        echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc
        echo "Refer to https://docs.ros.org/en/"${ROS_DISTRO}"/Tutorials/Configuring-ROS2-Environment.html to configure colcon"
          ;;
      * )
          echo "Okay, no problem. :) Let's move on!"
          echo "Skipping colcon"
          ;;
    esac