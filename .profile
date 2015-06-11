# -*- mode: shell-script -*-

# Modular Shell Configuration
#
# Sources files from ~/.profile.d that exist:
# - For things that apply across all POSIX shells, put in files
#   ending in .sh.
# - For things that apply only to Bash, end in .bash.
# - For things that apply only to Zsh, end in .zsh.
#
# For machine specific things:
# - Things applying across all machines are in the base ~/.profile.d
#   directory and are applied first
# - If a directory exists under ~/.profile.d that matches the
#   hostname, files from that directory are applied
#
# Since these files are sourced, the do not need to have executable
# permission.
#
# For things that might be shared, but aren't on every machine,
# put in ~/.profile.d/common and then source them using the function
# source_profile_common_file in a file in the local profile directory.
#

# "Global" variables for the profile
HOSTNAME=${HOSTNAME:-$(hostname)}
DEBUG=${DEBUG-}

dot_profile_sourced=${dot_profile_sourced-}
profile_d="$HOME/.profile.d"
local_profile_d="${profile_d}/${HOSTNAME}"

# TODO: Come up with a name that isn't a valid hostname to use here
common_profile_d="${profile_d}/common"

# This should only be sourced once
if [ -n "${dot_profile_sourced}" ]; then
    return
fi

# Functions:
# Error and Debug helpers
debug () {
    local debug_msg="$@"

    if [ -n "${DEBUG}" ] && [ -n "${debug_msg}" ]; then
        echo "${debug_msg}" 1>&2
    fi
}

error () {
    local error_code="${1}"; shift
    local error_msg="$@"

    if [ -n "${error_code}" ] && [ "${error_code}" -gt 0 ] && \
           [ -n "{error_msg}" ]; then
        echo "${error_msg}" 1>&2
        return "${error_code}"
    fi
}

# General sourcing helpers:
source_files_in_dir() {
    if [ $# -ne 2 ]; then
        return $(error 2 "source_files_in_dir requires two parameters, \
the directory to source and the filespec to source.")
    fi

    local dir="${1}"
    local filespec="${2}"
    local i

    if [ -d "${dir}" ]; then
        for i in ${dir}/${filespec}; do
            if [ -r "${i}" ]; then
               . "${i}"
            fi
        done
    fi
}

source_profile_common_file () {
    if [ -z "${common_profile_d}" ]; then
        return $(error 2 "source_profile_common_file requires \
common_profile_d be defined.")
    fi

    if [ $# -ne 1 ]; then
        return $(error 1 "source_profile_common_file requires a \
single parameter, the name of the file to source in \
${common_profile_d}.")
    fi

    local profile_file="${common_profile_d}"/"${1}"

    if [ -r "${profile_file}" ]; then
        . "${profile_file}"
    fi
}

# Sourcing helpers for POSIX shell files
source_posix_files_in_dir() {
    if [ $# -ne 1 ]; then
        return $(error 1 "source_posix_files_in_dir requires a single \
parameter, the directory to source.")
    fi

    local dir="${1}"
    local filespec="*.sh"

    source_files_in_dir "${dir}" "${filespec}"
}

source_posix_profile_d () {
    if [ -z "${profile_d}" ]; then
        return $(error 2 "source_posix_profile_d requires \
profile_d be defined.")
    fi

    debug "Sourcing POSIX scripts from ${profile_d}."

    source_posix_files_in_dir "${profile_d}"
}

source_posix_local_profile_d () {
    if [ -z "${local_profile_d}" ]; then
        return $(error 2 "source_posix_local_profile_d requires \
local_profile_d be defined.")
    fi

    debug "Sourcing POSIX scripts from ${local_profile_d}."

    source_posix_files_in_dir "${local_profile_d}"
}

debug "Sourcing ~/.profile"

# Source all profile and local profile POSIX files
source_posix_profile_d
source_posix_local_profile_d

# We have been sourced now
dot_profile_sourced=1

if [ -n "${BASH_VERSION}" ] && [ -r "${HOME}/.bash_profile" ]; then
    . "${HOME}/.bash_profile"
fi

if [ -n "${ZSH_VERSION}" ] && [ -r "${HOME}/.zprofile" ]; then
    . "${HOME}/.zprofile"
fi

if [ -r "${HOME}/.shellrc" ]; then
    . "${HOME}/.shellrc"
fi
