# -*- mode: shell-script -*-

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# UGLY hack to make sure this is done right
dot_shellrc_sourced=${dot_shellrc_sourced-}

# This is circuitous, but do this so the general shellrc is sourced,
# which will then source this file
if [ -z "${dot_shellrc_sourced}" ]; then
    . "${HOME}/.shellrc"
    return
fi

debug "Sourcing ~/.bashrc"

# TODO: Check for dependencies (functions, external programs, etc)
# if fn_exists "source_bash_files_in_dir"; then
# fi

# Global functions
source_bash_shellrc_d () {
    if [ -z "${shellrc_d}" ]; then
        return $(error 2 "${FUNCNAME} requires shellrc_d be set.")
    fi

    debug "Sourcing bash files in ${shellrc_d}"

    source_bash_files_in_dir "${shellrc_d}"
}

source_bash_local_shellrc_d () {
    if [ -z "${local_shellrc_d}" ]; then
        return $(error 2 \
"$(FUNCNAME) requires local_shellrc_d be set.")
    fi

    debug "Sourcing bash files in ${shellrc_d}"

    source_bash_files_in_dir "${local_shellrc_d}"
}

source_bash_shellrc_d
source_bash_local_shellrc_d
