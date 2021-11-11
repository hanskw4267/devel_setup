# devel-setup

Collection of setup scripts i use

Feel free to open a issue for any bugs you find, or any ideas for new scripts to add. :D

## Running the scripts

__BASH EXPECTED__  
Run the scripts in a terminal using

```shell
source <script_file>
```

___OR___

```shell
chmod +x <script_file>
./<script_file>
```

> ___Caution: scripts will ask if you want to accept all future prompts,
accepting will cause the script to attempt to install everything the script can install. (will still need inputs for stuff like git config, etc)___  
> ___YOU HAVE BEEN WARNED___

## The scripts

### [ros_install.sh](./ros_install.sh)

Choose between ROS1 distros and configurations to install on the system

1. melodic (bionic)
2. noetic (focal)

Script will attempt to check that the system has the correct ubuntu version for the chosen distro and will warn if check has failed (___warning ignorable___).

Additionally choose to...

1. Add installed ros' setup.bash sourcing to .bashrc
2. Install & init rosdep
3. Install catkin tools

----

### [ros2_install.sh](./ros2_install.sh)

Choose between ROS2 distros and configurations to install on the system

1. dashing (bionic)
2. foxy (focal)
3. galactic (focal)

Script will attempt to check that the system has the correct ubuntu version for the chosen distro and will warn if check has failed (___warning ignorable___).

Additionally choose to...

1. Add installed ros' setup.bash sourcing to .bashrc
2. Install & source colcon

----

### [basic_minimal.sh](./basic_minimal.sh)

Choose among set of common development/collaboration tools to install/config on the system.

Script will attempt to check that the system is ubuntu and will warn if check has failed (___warning ignorable___).

___Current set includes...___

#### __Using apt__

1. Terminator emulator
2. Vim editor
3. Nano editor
4. Wget
5. Curl
6. Openssh server and client
7. Build essentials and cmake
8. Pip3
9. Net-tools
10. Valgrind
11. htop
12. Nmap

#### __Others__

1. Git
    * Optional git "config" __global__ configuration
2. Visual studio code
    * Optional vscode extensions __after installing VSCode__ which includes...

        ##### __Default disabled__

        * [C/C++ Extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack)
        * [Python pack](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
        * [ROS pack](https://marketplace.visualstudio.com/items?itemName=ms-iot.vscode-ros)
        * [Java Extension pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)

        ##### __Default enabled__
        
        * [Gitlens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
        * [Remote SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
        * [Bracket pair colorizer 2](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2)
        * [Git graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)
        * [TODO highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight)
        * [Indent rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)
        * [Material icon theme](https://marketplace.visualstudio.com/items?itemName=pkief.material-icon-theme)
        * [Prettier formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
        * [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
        * [File header comment](https://marketplace.visualstudio.com/items?itemName=doi.fileheadercomment)
        * [C/C++ Include Guard](https://marketplace.visualstudio.com/items?itemName=akiramiyakoda.cppincludeguard)
3. My personal aliases (___not recommended to install___)
    * Will add my standard set of aliases to ~/.bashrc

----

### [basic_full.sh](./basic_full.sh)

Extra set development/collaboration tools to install/config on the system on top of the minimal install.  
__Running this script will also run the basic minimal install__  
Script will attempt to check that the system is ubuntu and will warn if check has failed (___warning ignorable___).

___Current set includes...___

__Using apt__

1. Snap store
2. Virtualenv
3. Flameshot

__From snap store__

1. [Spotify](https://snapcraft.io/spotify)
2. [Slack](https://snapcraft.io/slack)
3. [Slack terminal](https://snapcraft.io/slack-term)
4. [Telegram](https://snapcraft.io/telegram-desktop)
5. [Termius app](https://snapcraft.io/termius-app)
6. [Discord](https://snapcraft.io/discord)
7. [Skype](https://snapcraft.io/skype)
8. [Microsoft teams](https://snapcraft.io/teams)

__Others__

1. Google chrome browser
2. Teamviewer
3. Zoom
----

### [wine_install.sh](./wine_install.sh)

Installs the [WINE](https://www.winehq.org/) compatibility layer on a ubuntu system.

----

### [docker_install.sh](./docker_install.sh)

Installs [Docker](https://www.docker.com/) onto a ubuntu system.  
Optionally install docker compose
