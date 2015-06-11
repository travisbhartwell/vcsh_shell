debug "Sourcing ~/.shellrc.d/99-prompt.bash"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# TODO: Make sure window title is properly set
# TODO: Remove all setting of PS1 and PROMPT_COMMAND from other files
function _prompt_command()
{
    # Can't be local, the fns use this
    w="${PWD/#${HOME}/~}"
    local prompt_end="\$ "
    local width_threshold=$((COLUMNS / 4))

    if [ "${#w}" -gt "${width_threshold}" ]; then
        optional_split='\n'
    else
        optional_split=''
    fi

    # Set prompt_start by looping over array
    local prompt_start=''

    for prompt_fn in ${__prompt_fns[*]}; do
        prompt_start="${prompt_start}$(${prompt_fn})"
    done

    PS1="${prompt_start}${optional_split}${prompt_end}"
}

PROMPT_COMMAND=_prompt_command${PROMPT_COMMAND+; }$PROMPT_COMMAND
