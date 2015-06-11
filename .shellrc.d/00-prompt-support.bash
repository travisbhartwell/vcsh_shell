# Useful functions for helping maintain and compose a prompt

debug "Sourcing ~/.shellrc.d/00-prompt-support.bash"

function __add_new_prompt_fn()
{
    if [ $# -lt 1 ]; then
        return 1
    fi

    local next_index=${#__prompt_fns[@]}
    local fn="$@"

    __prompt_fns[${next_index}]="${fn}"
}

function __set_title_ps1()
{
    case "$TERM" in
        xterm*|rxvt*)
            echo -ne '\[${_set_title}\]'\
'${USER}@${HOSTNAME}:${w}'\
'\[${_end_set_title}\]'
            ;;
        *)
            ;;
    esac
}

# __add_new_prompt_fn __set_title_ps1

function __core_ps1()
{
    echo '\[$(_bold ${greenf})\]'\
'${USER}@${HOSTNAME}'\
'\[${_reset}\]'\
':'\
'\[$(_bold ${bluef})\]'\
'\w'\
'\[${_reset}\]'
}

__add_new_prompt_fn __core_ps1
