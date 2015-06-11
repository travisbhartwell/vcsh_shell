debug "Sourcing ~/.shellrc.d/01-history.bash"

HISTCONTROL=ignoreboth
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTIGNORE="&:ls:[bf]g:exit"

HISTSIZE=10000
HISTFILESIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

PROMPT_COMMAND="${PROMPT_COMMAND}${PROMPT_COMMAND+; }"
PROMPT_COMMAND="${PROMPT_COMMAND}history -a; history -n"

