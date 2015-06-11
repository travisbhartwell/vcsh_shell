debug "Sourcing ~/.shellrc.d/common/git.bash"

if fn_exists "__git_ps1"; then
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUPSTREAM='auto'
    export GIT_PS1_SHOWUPSTREAM \
           GIT_PS1_SHOWSTASHSTATE \
           GIT_PS1_SHOWDIRTYSTATE

    function __git_ps1_wrapper()
    {
        echo -ne '$(__git_ps1 "[\[$(_normal ${greenf})\]%s\[${_reset}\]]")'
    }

    __add_new_prompt_fn __git_ps1_wrapper
fi
