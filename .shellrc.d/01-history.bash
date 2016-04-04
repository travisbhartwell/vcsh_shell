debug "Sourcing ~/.shellrc.d/01-history.bash"

HISTCONTROL=ignoreboth
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
HISTIGNORE="&:ls:[bf]g:exit"
# Change history file so it isn't accidentally overwritten in new
# bash environments
HISTFILE="${HOME}"/.bash_history_file
HISTSIZE=10000
HISTFILESIZE=10000

# append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

PROMPT_COMMAND="${PROMPT_COMMAND}${PROMPT_COMMAND+; }"
PROMPT_COMMAND="${PROMPT_COMMAND}history -a; history -n"

