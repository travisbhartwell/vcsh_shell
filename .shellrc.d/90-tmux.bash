# Useful functions for use with TMUX

debug "Sourcing ~/.shellrc.d/90-tmux.bash"

function __update_tmux_env()
{
    if [ -n "${TMUX}" ]; then
        for var in DISPLAY GPG_AGENT_INFO SSH_AGENT_PID SSH_AUTH_SOCK SSH_CONNECTION; do
            local var_value=$(tmux show-environment | grep "^$var")
            if [ -n "$var_value" ]; then
                export "$var_value"
            fi
        done
    fi
}

__add_new_prompt_command __update_tmux_env
