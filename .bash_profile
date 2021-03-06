# Source all .dot files, starting with .extra, which shouldn't be committed
for file in ~/.{extra,bash_prompt,exports,aliases}; do
    [ -r "$file" ] && source "$file"
done
unset file

# Bash autocompletion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
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

# realtime bash_history, with timestamps
export HISTTIMEFORMAT='%F %T '
export HISTCONTROL=ignoredups:erasedups         # no duplicate entries
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
type shopt &> /dev/null && shopt -s histappend  # append to history, don't overwrite it
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
