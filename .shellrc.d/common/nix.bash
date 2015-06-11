debug "Sourcing ~/.shellrc.d/common/nix.sh"

__nix_prompt_fn()
{
    if [ -n "${IN_NIX_SHELL}" ]; then
        echo -ne '\[$(_normal ${yellowf})\][NIX SHELL]\[${_reset}\]'
    fi
}

__add_new_prompt_fn __nix_prompt_fn
