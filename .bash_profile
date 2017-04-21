# Load rbenv automatically  
eval "$(rbenv init -)"

# Load phpbrew
if [[ -e ~/.phpbrew/bashrc ]]; then
	export PHPBREW_SET_PROMPT=1
	export PHPBREW_RC_ENABLE=1
	source ~/.phpbrew/bashrc
fi

# Source all .dot files, starting with .extra, which shouldn't be committed
for file in ~/.{extra,bash_prompt,exports,aliases}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Bash autocompletion
if [ -f /usr/share/bash_completion ]; then
  . /usr/share/bash_completion
fi

# Prompt fix for Gnome
if [ -z "$COLORTERM" ] && cat /proc/$PPID/exe 2> /dev/null | grep -q gnome-terminal; then
     export COLORTERM=gnome-terminal
fi

# to help sublimelinter etc with finding my PATHS
case $- in
   *i*) source ~/.extra
esac

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline


HISTSIZE=9000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignorespace:ignoredups

_bash_history_sync() {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  builtin history -c         #3
  builtin history -r         #4
}

history() {                  #5
  _bash_history_sync
  builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
