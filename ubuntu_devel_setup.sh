#! /usr/bin/env bash

# Post install script to setup a linux development environment

onlyroot="Do not run this script as root!!!"

if [ $(whoami) == "root" ]; then     #"guarding against root execution"
    echo -e $COLOR$onlyroot$MONO
    exit 0
fi

ask_user () {
  read -r -p "$1 [y/N]" reply
  case "$reply" in
    [yY][eE][sS]|[yY] )
      true
      ;;
    * ) 
      false
      ;;
  esac
}

apt_install () {
  if ask_user "Do you wish to install $1?? "; then
    sudo apt install -y $1
    if [ $? -eq 0 ]; then
      echo "<--------------------------- $1 Install OK"
    else
      echo "<--------------------------- $1 Install failed"
      exit $?
    fi
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping $1"
  fi
}

code_install () {
  if ask_user "Do you wish to install the extension $1?? "; then
    code --install-extension $1
    if [ $? -eq 0 ]; then
      echo "<--------------------------- $1 Install OK"
    else
      echo "<--------------------------- $1 Install failed"
      exit $?
    fi
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping $1"
  fi
}

snap_install () {
  if ask_user "Do you wish to install ${1}?? Make SURE you have snap store installed?? "; then
    sudo snap install $1
    if [ $? -eq 0 ]; then
      echo "<--------------------------- $1 Install OK"
    else
      echo "<--------------------------- $1 Install failed"
      exit $?
    fi
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping $1"
  fi
}


echo "-------------------------------------------------"
echo "<-- Ubuntu Development Setup - Hans -->"
echo "-------------------------------------------------"

echo "-------------------------------------------------"
echo " <-- Checking system version -->"
echo "-------------------------------------------------"

if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
fi

SYS_CHECK_OK=0
if [[ "$OS" == "Ubuntu" ]] ; then
    SYS_CHECK_OK=1
    echo " <-- SYSTEM VERSION CHECK OK -->\n"
else
    read -r -p " Your system is not Ubuntu, continue to setup anyways? [y/N]" reply
    case "$reply" in
      [yY][eE][sS]|[yY] )
        SYS_CHECK_OK=1;
        echo " <-- SYSTEM VERSION CHECK FAILED BUT CONTINUING -->\n"
        ;;
      * )
        SYS_CHECK_OK=0
        echo " <-- SYSTEM VERSION CHECK FAILED -->\n"
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
echo "<-- Installing common tools -->"
apt_install "snapd"
apt_install "terminator"
apt_install "vim"
apt_install "nano"
apt_install "wget"
apt_install "curl"
apt_install "openssh-server openssh-client"
apt_install "build-essential cmake"
apt_install "virtualenv"
apt_install "python3-pip"
apt_install "net-tools"

echo "-------------------------------------------------"
echo "<-- Installing snaps -->"
snap_install "spotify"
snap_install "slack --classic"
snap_install "slack-term"
snap_install "telegram-desktop"
snap_install "termius-app"

echo "-------------------------------------------------"
echo "<-- Git install and config -->"
if ask_user "Do you wish to install git??" ; then
  echo "Installing Git"
  sudo apt install -y git
  if ask_user "Do you wish to configure git??" ; then
    echo "What username do you want to use for git?"
    read git_username
    git config --global user.name "$git_username"
    echo "-----------------------------------------"
    echo "What user email do you want to use for git?"
    read git_useremail
    git config --global user.email "$git_useremail"
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping Git config"
  fi
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping Git"
fi

echo "-------------------------------------------------"
echo "<-- VSCode install and config -->"
if ask_user "Do you wish to install VSCode??" ; then
  echo "Installing VSCode"
  sudo apt install -y apt-transport-https
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
  rm -f packages.microsoft.gpg
  sudo apt update
  sudo apt install -y code
  code --version
  echo "-----------------------------------"
  if ask_user "Do you wish to install some of my favourite VSCode extentions? (you can choose for each)" ; then
    echo "Installing VSCode extensions"
    code_install eamodio.gitlens
    code_install coenraads.bracket-pair-colorizer-2
    code_install ms-vscode.cpptools-extension-pack 
    code_install mhutchie.git-graph
    code_install wayou.vscode-todo-highlight
    code_install ms-python.python
    code_install oderwat.indent-rainbow
    code_install pkief.material-icon-theme
    code_install esbenp.prettier-vscode
    code_install ms-iot.vscode-ros
    code_install vscjava.vscode-java-pack
  else
    echo "Okay, no problem. :) Let's move on!"
    echo "Skipping VSCode extensions"
  fi
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping VSCode"
fi

echo "-------------------------------------------------"
if ask_user "Do you wish to install google chrome??" ; then
  echo "Installing chrome"
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install ./google-chrome-stable_current_amd64.deb
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping google chrome"
fi

echo "-------------------------------------------------"
if ask_user "Do you wish to add my aliases to bashrc??" ; then
  echo "#My own aliases----" >> ~/.bashrc
  echo "alias uupgrade="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove"" >> ~/.bashrc
  echo "alias git="git "" >> ~/.bashrc
  echo "alias clone="clone --recursive"" >> ~/.bashrc
  echo "alias cd="cd "" >> ~/.bashrc
else
  echo "Okay, no problem. :) Let's move on!"
  echo "Skipping aliases"
fi

echo "<-- cleaning -->"
sudo apt autoremove -y

echo "-------------------------------------------------"
echo "<-- Linux Development Setup Done -->"
echo "-------------------------------------------------"