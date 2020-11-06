#######################################
# Define variables used to load configs
#######################################
local ZSH_BASE=/etc/zsh
local ZSH_CONF=${ZSH_BASE}/conf
local ZSH_PLUGINS=${ZSH_BASE}/plugins

######################################
# Set default shell variables
######################################
export EDITOR="vim"
export VISUAL="vim"
export PAGER="less"
export LANG="en_US.UTF-8"

######################################
# Miscellaneous options
######################################
emulate sh -c 'source /etc/profile'  # Load /etc/profile content file
rehash								 # Force zsh to reanalyze command for completion at start
setopt correctall					 # Set command autocorrection
setopt ZLE							 # Enable the ZLE line editor
declare -U path						 # Prevent duplicate entries in path
setopt NO_HUP						 # Force system to kill process under zsh on exit
unsetopt vi							 # Set zsh to vi comportment in case of ^Esc pressed
autoload -Uz colors && colors		 # Force zsh to use colors for commands
setopt nomatch
setopt notify
autoload -Uz promptinit				 # Force autorefresh prompt on each lines
promptinit							 # Force autorefresh prompt on each lines
setopt prompt_subst					 # Force autorefresh prompt on each lines

#######################################
# Load various configurations
#######################################
source ${ZSH_CONF}/history.zsh
source ${ZSH_CONF}/completion.zsh
source ${ZSH_CONF}/aliases.zsh
source ${ZSH_CONF}/keybinding.zsh
source ${ZSH_CONF}/plugins.zsh
source ${ZSH_CONF}/prompt.zsh
