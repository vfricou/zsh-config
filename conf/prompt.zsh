if [ $EUID -eq 0 ]
then
       PROMPT="%{$fg[red]%}%~%{$reset_color%} ${GIT_PS1}
%# "
       RPROMPT="%{$fg[red]%}%(?..%?)%{$reset_color%} [%m:%{$terminfo[bold]$fg[red]%}%n%{$reset_color%}] %T ${batteryp}"
       else
       PROMPT="%{$terminfo[bold]$fg[blue]%}%~%{$reset_color%} ${GIT_PS1}
%# "
       RPROMPT="%{$fg[red]%}%(?..%?)%{$reset_color%} [%m:%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}] %T ${batteryp}"
fi

