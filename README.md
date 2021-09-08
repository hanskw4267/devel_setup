# devel-setup

Collection of setup scripts i use

## Running the scripts

Run the scripts using

```shell
source <script_file>
```

__Or__

```shell
chmod +x <script_file>
./<script_file>
```

___Caution: scripts will ask if you want to accept all future prompts, 
accepting will cause the script to attempt to install everything the script can install. (will still need inputs for stuff like git config, etc)___  

__YOU HAVE BEEN WARNED__

## The scripts

### [ros_install.sh](./ros_install.sh)

Choose between ROS1 distros and configurations to install on the system

1. melodic
2. noetic

Script will attempt to check that the system has the correct ubuntu version for the chosen distro and will warn if check has failed (___warning ignorable___).

Additionally choose to...

1. Add installed ros' setup.bash sourcing to .bashrc
2. Install & init rosdep
3. Install catkin tools

### [ros2_install.sh](./ros2_install.sh)

Choose between ROS2 distros and configurations to install on the system

1. dashing
2. foxy
3. galactic

Script will attempt to check that the system has the correct ubuntu version for the chosen distro and will warn if check has failed (___warning ignorable___).

Additionally choose to...

1. Add installed ros' setup.bash sourcing to .bashrc
2. Install & source colcon

### [ubuntu_devel_setup.sh](./ubuntu_devel_setup.sh)

Choose among set of common development/collaboration tools to install/config on the system.

Script will attempt to check that the system is ubuntu and will warn if check has failed (___warning ignorable___).

___Current set includes...___

#### __Using apt__

1. Snap store
2. Terminator emulator
3. Vim editor
4. Nano editor
5. Wget
6. Curl
7. Openssh server and client
8. Build essentials and cmake
9. Virtualenv
10. Pip3
11. Net-tools

#### __From snap store__

1. [Spotify](https://snapcraft.io/spotify)
2. [Slack](https://snapcraft.io/slack)
3. [Slack terminal](https://snapcraft.io/slack-term)
4. [Telegram](https://snapcraft.io/telegram-desktop)
5. [Termius app](https://snapcraft.io/termius-app)

#### __Others__

1. Git
    * Optional git "config" __global__ configuration
2. Visual studio code
    * Optional vscode extensions __when installed VSCode__ which includes...
        * [Gitlens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
        * [Bracket pair colorizer 2](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer-2)
        * [C/C++ Extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack)
        * [Git graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)
        * [TODO highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight)
        * [Python pack](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
        * [Indent rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)
        * [Material icon theme](https://marketplace.visualstudio.com/items?itemName=pkief.material-icon-theme)
        * [Prettier formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
        * [ROS pack](https://marketplace.visualstudio.com/items?itemName=ms-iot.vscode-ros)
        * [Java Extension pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)
3. Google chrome browser
4. Teamviewer
5. My personal aliases (___not recommended to install___)
    * Will add my standard set of aliases to ~/.bashrc 
