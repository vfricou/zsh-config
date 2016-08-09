Zsh configuration
======

This repository contain a full functionnal configuration for zsh.

## Installation

### Cloning configuration
To clone this repository **INCLUDING** the submodules them is other git repositories.
> git clone --recursive https://github.com/vfricou/zsh_config /etc/zsh

### Linking vimrc
Probably, on certain Linux distribution, you could make a link of zshrc file :
> ln -s /etc/zsh/zshrc /etc/zshrc

## Include
This configuration include some configurations and plugins.
- Archlinux zsh runtime environment.
- Autosuggestion plugin (is a submodule from https://github.com/zsh-users/zsh-autosuggestions).
- Battery percentage display on prompt line (To activate).
- A colored man pages.
- A GIT informationnal prompt.
- Sprunge command line directly included to paste file/text.
- A ssh-agent autoevaluation (Is disabled and is working not really properly now).
- Mosh host completion.
- Bind-key correction for Origin/End keys
