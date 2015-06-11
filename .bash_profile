# -*- mode: shell-script -*-

# UGLY hack to make sure this is done right
dot_profile_sourced=${dot_profile_sourced-}

# This is circuitous, but do this so the general profile is sourced,
# which will then source this file
if [ -z "${dot_profile_sourced}" ]; then
    . "${HOME}/.profile"
    return
fi

debug "Sourcing ~/.bash_profile"

# Move this into a proper place
declare -a __prompt_fns
declare -a __normal_colors
declare -a __bold_colors

export __prompt_fns __normal_colors __bold_colors

# TODO: Check for dependencies (functions, external programs, etc)

# Helper function for sourcing bash files
source_bash_files_in_dir() {
    if [ "$#" -ne 1 ]; then
        return $(error 2 "${FUNCNAME} requires a single parameter, \
the directory to source.")
    fi

    local dir="${1}"
    local filespec="*.bash"

    source_files_in_dir "${dir}" "${filespec}"
}

source_bash_profile_d () {
    if [ -z "${profile_d}" ]; then
        return $(error 2 "${FUNCNAME} requires profile_d be set.")
    fi

    debug "Sourcing bash files in ${profile_d}"

    source_bash_files_in_dir "${profile_d}"
}

source_bash_local_profile_d () {
    if [ -z "${local_profile_d}" ]; then
        return $(error 2 \
"${FUNCNAME} requires local_profile_d be set.")
    fi

    debug "Sourcing bash files in ${local_profile_d}"

    source_bash_files_in_dir "${local_profile_d}"
}

source_bash_profile_d
source_bash_local_profile_d
