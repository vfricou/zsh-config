#######################################
# Define variables used to load configs
#######################################
local ZSH_BASE=/etc/zsh
local ZSH_PLUGINS=${ZSH_BASE}/plugins


### Command highlightning if exist
if [[ -r ${ZSH_PLUGINS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source ${ZSH_PLUGINS}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

## Set zsh environment
# git prompt
if [[ -r ${ZSH_PLUGINS}/git-prompt/git-prompt.plugin.zsh ]]; then
	source ${ZSH_PLUGINS}/git-prompt/git-prompt.plugin.zsh
	GIT_PS1='$(git_prompt_string)'
fi
# Colored man
if [[ -r ${ZSH_PLUGINS}/colored-man/colored-man.plugin.zsh ]]; then
	source ${ZSH_PLUGINS}/colored-man/colored-man.plugin.zsh
fi
# Source sprunge command to paste file
if [[ -r ${ZSH_PLUGINS}/sprunge/sprunge.plugin.zsh ]]; then
	source ${ZSH_PLUGINS}/sprunge/sprunge.plugin.zsh
fi
# Source ssh-agent auto evaluation
#if [[ -r ${ZSH_PLUGINS}/ssh-agent/ssh-agent.plugin.zsh ]]; then
#	source ${ZSH_PLUGINS}/ssh-agent/ssh-agent.plugin.zsh
#fi
# Zsh autosuggestions
if [[ -r ${ZSH_PLUGINS}/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
	source ${ZSH_PLUGINS}/zsh-autosuggestions/zsh-autosuggestions.zsh
fi
# source kubernetes command completion
if [[ -r ${ZSH_PLUGINS}/kubectl/kubectl.plugin.zsh && $+commands[kubectl] ]]; then
	source ${ZSH_PLUGINS}/kubectl/kubectl.plugin.zsh
fi

# Source ansible_init plugin
if [[ -r ${ZSH_PLUGINS}/ansible_init/ansible_init.plugin.zsh && -f /usr/bin/ansible-playbook ]]; then
  source ${ZSH_PLUGINS}/ansible_init/ansible_init.plugin.zsh
fi

# Source ansible_init plugin
if [[ -r ${ZSH_PLUGINS}/macos_specifics.plugin.zsh ]]; then
  source ${ZSH_PLUGINS}/macos_specifics.plugin.zsh
fi



