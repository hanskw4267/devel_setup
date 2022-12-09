# devel-setup

Collection of setup scripts i use.

Tested on Ubuntu 18.04/20.04/22.04

Feel free to open a issue for any bugs you find, or any ideas for new scripts to add. :D


## Running the scripts

__BASH EXPECTED__  
Run the scripts in a terminal using

```shell
source <script_file>
```

___OR___

```shell
./<script_file>
```

> ___Caution: scripts will ask if you want to accept all future prompts for specific sections,
accepting will cause the script to attempt to install everything the script can install. (will still need inputs for stuff like git config, etc)___  
> ___YOU HAVE BEEN WARNED___

## The scripts

### [basic_minimal.sh](./basic_minimal.sh)

Choose among set of common development/collaboration tools to install/config on the system.

Script will attempt to check that the system is ubuntu and will warn if check has failed (___warning ignorable___).

___Current set includes...___

#### __Using apt__

1. terminator emulator
2. vim editor
3. nano editor
4. wget
5. curl
6. openssh-server
7. build-essential
8. cmake
9. python3-pip
10. net-tools
11. valgrind
12. htop
13. nmap
14. can-utils
15. software-properties-common
16. screen

#### __Others__

1. Git
    * Optional git "config" __global__ configuration
2. Visual studio code
    * Optional vscode extensions __after installing VSCode__ which includes...
        * [C/C++ Extension pack](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack)
        * [Python pack](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
        * [ROS pack](https://marketplace.visualstudio.com/items?itemName=ms-iot.vscode-ros)
        * [Gitlens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
        * [Remote SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
        * [Git graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)
        * [TODO highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight)
        * [Indent rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow)
        * [Material icon theme](https://marketplace.visualstudio.com/items?itemName=pkief.material-icon-theme)
        * [Prettier formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)
        * [YAML](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
        * [File header comment](https://marketplace.visualstudio.com/items?itemName=doi.fileheadercomment)
        * [C/C++ Include Guard](https://marketplace.visualstudio.com/items?itemName=akiramiyakoda.cppincludeguard)
3. My personal aliases (___not recommended to install, will always ask___)
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
3. [Telegram](https://snapcraft.io/telegram-desktop)
4. [Discord](https://snapcraft.io/discord)
5. [Microsoft teams](https://snapcraft.io/teams)

__Others__

1. Google chrome browser
2. Teamviewer
3. Zoom
4. [Pyenv](https://github.com/pyenv/pyenv)
5. [Kicad 6.0](https://www.kicad.org/)
6. [Virtualbox 6.1](https://www.virtualbox.org/wiki/Downloads)

----

### [Others](./scripts)

These scripts each install a specific tool/software/library, each can be ran on their own.