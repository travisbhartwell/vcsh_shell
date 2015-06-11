debug "Sourcing ~/.shellrc.d/common/virtualenvwrapper.bash"

local wrapper_path=$(which virtualenvwrapper.sh)

if [ -z "${wrapper_path}" ]; then
    . "${wrapper_path}"

    declare -x virtualenv_prompt

    __virtualenv_prompt_fn()
    {
        if [ -n "${VIRTUAL_ENV}" ]; then
            if [ "`basename \"$VIRTUAL_ENV\"`" = "__" ] ; then
                # special case for Aspen magic directories
                # see http://www.zetadev.com/software/aspen/
                virtualenv_prompt="[`basename \`dirname \"$VIRTUAL_ENV\"\``]"
            else
                virtualenv_prompt="(`basename \"$VIRTUAL_ENV\"`)"
            fi
            echo -ne '\[$(_normal ${yellowf})\]'\
"${virtualenv_prompt}"\
'\[${_reset}\]'
        fi
    }

    __add_new_prompt_fn __virtualenv_prompt_fn

    # Let me handle the prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    export VIRTUAL_ENV_DISABLE_PROMPT virtualenv_prompt
fi
