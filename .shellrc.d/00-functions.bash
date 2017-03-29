# Useful bash-specific functions and aliases needed only for
# interactive invocations

debug "Sourcing ~/.shellrc.d/00-functions.bash"

if ! on_osx; then
    alias ls='ls --color=auto --group-directories-first'
else
    alias gls='gls --color=auto --group-directories-first'
fi
