# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
export EDITOR="vim"
export VISUAL="vim"

autoload -Uz compinit
compinit
autoload -Uz bashcompinit
bashcompinit
setopt correctall
autoload -Uz promptinit
promptinit
autoload -Uz colors && colors

bindkey '^R' history-incremental-search-backward

setopt appendhistory autocd beep extendedglob nomatch notify
### Command highlightning if exist
if [[ -r /etc/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /etc/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
fi

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ":completion:*:commands" rehash 1

setopt prompt_subst

## Set zsh environment
# git prompt
if [[ -r /etc/zsh/plugins/git-prompt/git-prompt.plugin.zsh ]]; then
	source /etc/zsh/plugins/git-prompt/git-prompt.plugin.zsh
	GIT_PS1='$(git_prompt_string)'
fi
# Bind keys for Orig/End/…
if [[ -r /etc/zsh/plugins/bind_keys/bind_keys.plugin.zsh ]]; then
	source /etc/zsh/plugins/bind_keys/bind_keys.plugin.zsh
fi
# Prompt insertion for battery status on RPROMT
#if [[ -r /sys/class/power_supply/AC && -r /sys/class/power_supply/BAT0 ]]; then
#	local batteryp='$(/etc/zsh/plugins/battery/battery.sh)'
#fi
# Colored man
if [[ -r /etc/zsh/plugins/colored-man/colored-man.plugin.zsh ]]; then
	source /etc/zsh/plugins/colored-man/colored-man.plugin.zsh
fi
# Mosh environment setting to ssh
if [[ -r /etc/zsh/plugins/mosh/mosh.plugin.zsh ]]; then
	source /etc/zsh/plugins/mosh/mosh.plugin.zsh
fi
# Source sprunge command to paste file
if [[ -r /etc/zsh/plugins/sprunge/sprunge.plugin.zsh ]]; then
	source /etc/zsh/plugins/sprunge/sprunge.plugin.zsh
fi
# Source ssh-agent auto evaluation
#if [[ -r /etc/zsh/plugins/ssh-agent/ssh-agent.plugin.zsh ]]; then
#	source /etc/zsh/plugins/ssh-agent/ssh-agent.plugin.zsh
#fi

# Zsh autosuggestions
if [[ -r /etc/zsh/plugins/autosuggestions/zsh-autosuggestions.zsh ]]; then
	source /etc/zsh/plugins/autosuggestions/zsh-autosuggestions.zsh
fi

# Source sprunge command to paste file
if [[ -r /etc/zsh/plugins/docker/docker.plugin.zsh ]]; then
	source /etc/zsh/plugins/docker/docker.plugin.zsh
fi

##### Aliases
	alias ls="ls --color"
	alias whatismyip="dig +short myip.opendns.com @resolver1.opendns.com"

# Set the right-hand prompt
if [ "`id -u`" -eq 0 ];then
	PROMPT="
%{$fg[red]%}%~%{$reset_color%} ${GIT_PS1}
%# "
	RPROMPT="%{$fg[red]%}%(?..%?)%{$reset_color%} [%m:%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}] %T ${batteryp}"
	else
	PROMPT="
%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%} ${GIT_PS1}
%# "
	RPROMPT="%{$fg[red]%}%(?..%?)%{$reset_color%} [%m:%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}] %T ${batteryp}"
fi
