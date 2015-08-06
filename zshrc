# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

autoload -Uz compinit
compinit
autoload -Uz bashcompinit
bashcompinit
setopt correctall
autoload -Uz promptinit
promptinit
autoload -Uz colors && colors

setopt appendhistory autocd beep extendedglob nomatch notify
if [[ -z "$DEBIAN_PREVENT_KEYBOARD_CHANGES" ]] &&
	[[ "$TERM" != 'emacs' ]]
then
	typeset -A key
	key=(
		BackSpace  "${terminfo[kbs]}"
		Home       "${terminfo[khome]}"
		End        "${terminfo[kend]}"
		Insert     "${terminfo[kich1]}"
		Delete     "${terminfo[kdch1]}"
		Up         "${terminfo[kcuu1]}"
		Down       "${terminfo[kcud1]}"
		Left       "${terminfo[kcub1]}"
		Right      "${terminfo[kcuf1]}"
		PageUp     "${terminfo[kpp]}"
		PageDown   "${terminfo[knp]}"
	)
	function bind2maps () {
		local i sequence widget
		local -a maps
		while [[ "$1" != "--" ]]; do
			maps+=( "$1" )
			shift
		done
		shift
		sequence="${key[$1]}"
		widget="$2"
		[[ -z "$sequence" ]] && return 1
		for i in "${maps[@]}"; do
			bindkey -M "$i" "$sequence" "$widget"
			done
	}
	bind2maps emacs             -- BackSpace   backward-delete-char
	bind2maps       viins       -- BackSpace   vi-backward-delete-char
	bind2maps             vicmd -- BackSpace   vi-backward-char
	bind2maps emacs             -- Home        beginning-of-line
	bind2maps       viins vicmd -- Home        vi-beginning-of-line
	bind2maps emacs             -- End         end-of-line
	bind2maps       viins vicmd -- End         vi-end-of-line
	bind2maps emacs viins       -- Insert      overwrite-mode
	bind2maps             vicmd -- Insert      vi-insert
	bind2maps emacs             -- Delete      delete-char
	bind2maps       viins vicmd -- Delete      vi-delete-char
	bind2maps emacs viins vicmd -- Up          up-line-or-history
	bind2maps emacs viins vicmd -- Down        down-line-or-history
	bind2maps emacs             -- Left        backward-char
	bind2maps       viins vicmd -- Left        vi-backward-char
	bind2maps emacs             -- Right       forward-char
	bind2maps       viins vicmd -- Right       vi-forward-char
	# Make sure the terminal is in application mode, when zle is
	# active. Only then are the values from $terminfo valid.
	if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
		function zle-line-init () {
			emulate -L zsh
			printf '%s' ${terminfo[smkx]}
		}
		function zle-line-finish () {
			emulate -L zsh
			printf '%s' ${terminfo[rmkx]}
		}
		zle -N zle-line-init
		zle -N zle-line-finish
	else
		for i in {s,r}mkx; do
			(( ${+terminfo[$i]} )) || debian_missing_features+=($i)
		done
		unset i
	fi
	unfunction bind2maps
fi

### Command highlightning if exist
if [[ -r /etc/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
	source /etc/zsh/syntax-highlighting/zsh-syntax-highlighting.zsh
fi

### Source git prompt configuration 
source /etc/zsh/git-prompt.sh

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:mv:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ":completion:*:commands" rehash 1

local batteryp='$(/etc/zsh/battery.sh)'
setopt prompt_subst
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}↑%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}↓%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}✖%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[blue]%}✚%{$reset_color%}"
GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔%{$reset_color%}"
# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
	(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}
# Show different symbols as appropriate for various Git repository states
parse_git_state() {
	# Compose this value via multiple conditional appends.
	local GIT_STATE=""
	local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
	if [ "$NUM_AHEAD" -gt 0 ]; then
		GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
	fi
	local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
	if [ "$NUM_BEHIND" -gt 0 ]; then
		GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
	fi
	local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
	if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
	fi
	if [[ $(git ls-files --other --exclude-standard | tail -1 2> /dev/null) != "" ]]; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
	fi
	if ! git diff --quiet 2> /dev/null; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
	fi
	if ! git diff --cached --quiet 2> /dev/null; then
		GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
	fi
	if [[ $GIT_STATE != "" ]]; then
		echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
	else
		echo "$GIT_PROMPT_PREFIX$GIT_PROMPT_CLEAN$GIT_PROMPT_SUFFIX"
	fi
}
# If inside a Git repository, print its branch and state
git_prompt_string() {
	local git_where="$(parse_git_branch)"
	[ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}

##### Aliases
	alias ls="ls --color"


# Set the right-hand prompt
GIT_PS1='$(git_prompt_string)'
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
