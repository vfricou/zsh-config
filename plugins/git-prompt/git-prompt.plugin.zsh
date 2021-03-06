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
	if [ "${NUM_AHEAD}" -gt 0 ]; then
		GIT_STATE=${GIT_STATE}${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
	fi
	local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
	if [ "${NUM_BEHIND}" -gt 0 ]; then
		GIT_STATE=${GIT_STATE}${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
	fi
	local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
	if [ -n ${GIT_DIR} ] && test -r $GIT_DIR/MERGE_HEAD; then
		GIT_STATE=${GIT_STATE}${GIT_PROMPT_MERGING}
	fi
	local GIT_UNTRACKED="$(git ls-files --other --exclude-standard|wc -l 2>/dev/null)"
	if [ "${GIT_UNTRACKED}" != "0" ]; then
		GIT_STATE=${GIT_STATE}${GIT_PROMPT_UNTRACKED}${GIT_UNTRACKED}
	fi
	local GIT_MODIFIED="$(git ls-files --modified --exclude-standard|wc -l 2>/dev/null)"
	if [ "${GIT_MODIFIED}" != "0" ]; then
		GIT_STATE=${GIT_STATE}${GIT_PROMPT_MODIFIED}${GIT_MODIFIED}
	fi
	local GIT_STAGED="$(git diff --name-only --cached | wc -l)"
	if [ "${GIT_STAGED}" != "0" ]; then
		GIT_STATE=${GIT_STATE}${GIT_PROMPT_STAGED}${GIT_STAGED}
	fi
	if [[ ${GIT_STATE} != "" ]]; then
		echo "${GIT_PROMPT_PREFIX}${GIT_STATE}${GIT_PROMPT_SUFFIX}"
	else
		echo "${GIT_PROMPT_PREFIX}${GIT_PROMPT_CLEAN}${GIT_PROMPT_SUFFIX}"
	fi
}
# If inside a Git repository, print its branch and state
git_prompt_string() {
	local git_where="$(parse_git_branch)"
	[ -n "${git_where}" ] && echo "${GIT_PROMPT_SYMBOL}$(parse_git_state)${GIT_PROMPT_PREFIX}%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}${GIT_PROMPT_SUFFIX}"
}
