
get_space () {
  local STR=$1$2
  local zero='%([BSUbfksu]|([FB]|){*})'
  local LENGTH=${#${(S%%)STR//$~zero/}}
  local SPACES=""
  (( LENGTH = ${COLUMNS} - $LENGTH - 1))

  for i in {0..$LENGTH}
    do
      SPACES="$SPACES "
    done

  echo $SPACES
}

if [[ $EUID -eq 0 ]]
then
	_PLEFT="%{$fg[red]%}%~%{$reset_color%} ${GIT_PS1}"
	_PRIGHT="%{$fg[red]%}%(?..%?)%{$reset_color%} [%m:%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}] %T ${batteryp}"
else
	_PLEFT="%{%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%} ${GIT_PS1}"
	_PRIGHT="%{%{$terminfo[bold]$fg[blue]%}%(?..%?)%{$reset_color%} [%m:%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}] %T ${batteryp}"
fi

prompt_precmd () {
  _SPACES=`get_space $_PLEFT $_PRIGHT`
  print
  print -rP "$_PLEFT$_SPACES$_PRIGHT"
}

setopt prompt_subst
PROMPT="%# "
autoload -U add-zsh-hook
add-zsh-hook precmd prompt_precmd