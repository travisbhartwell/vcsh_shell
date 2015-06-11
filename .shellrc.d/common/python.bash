debug "Sourcing ~/.shellrc.d/common/python.bash"

[ -x "$(which pip 2> /dev/null)" ] && eval "$(pip completion --bash)"
