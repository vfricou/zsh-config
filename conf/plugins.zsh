#######################################
# Define variables used to load configs
#######################################
local ZSH_BASE=/etc/zsh
local ZSH_PLUGINS=$ZSH_BASE/plugins


### Command highlightning if exist
if [[ -r $ZSH_PLUGINS/syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source $ZSH_PLUGINS/syntax-highlighting/zsh-syntax-highlighting.zsh
fi

## Set zsh environment
# git prompt
if [[ -r $ZSH_PLUGINS/git-prompt/git-prompt.plugin.zsh ]]; then
	source $ZSH_PLUGINS/git-prompt/git-prompt.plugin.zsh
	GIT_PS1='$(git_prompt_string)'
fi
# Prompt insertion for battery status on RPROMT
if [[ -r /sys/class/power_supply/AC && -r /sys/class/power_supply/BAT0 ]]; then
	local batteryp='$($ZSH_BASE/plugins/battery/battery.sh)'
fi
# Colored man
if [[ -r $ZSH_PLUGINS/colored-man/colored-man.plugin.zsh ]]; then
	source $ZSH_PLUGINS/colored-man/colored-man.plugin.zsh
fi
# Mosh environment setting to ssh
if [[ -r $ZSH_PLUGINS/mosh/mosh.plugin.zsh ]]; then
	source $ZSH_PLUGINS/mosh/mosh.plugin.zsh
fi
# Source sprunge command to paste file
if [[ -r $ZSH_PLUGINS/sprunge/sprunge.plugin.zsh ]]; then
	source $ZSH_PLUGINS/sprunge/sprunge.plugin.zsh
fi
# Source ssh-agent auto evaluation
if [[ -r $ZSH_PLUGINS/ssh-agent/ssh-agent.plugin.zsh ]]; then
	source $ZSH_PLUGINS/ssh-agent/ssh-agent.plugin.zsh
fi

# Zsh autosuggestions
if [[ -r $ZSH_PLUGINS/autosuggestions/zsh-autosuggestions.zsh ]]; then
	source $ZSH_PLUGINS/autosuggestions/zsh-autosuggestions.zsh
fi

# Source sprunge command to paste file
if [[ -r $ZSH_PLUGINS/docker/docker.plugin.zsh ]]; then
	source $ZSH_PLUGINS/docker/docker.plugin.zsh
fi

# source kubernetes command completion
if [[ -r $ZSH_PLUGINS/kubectl/kubectl.plugin.zsh ]]; then
	source $ZSH_PLUGINS/kubectl/kubectl.plugin.zsh
fi