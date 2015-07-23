# Useful generic POSIX shell functions needed for all invocations

debug "Sourcing .profile.d/00-functions.sh"

# Helper functions for managing the PATH
sanitize_path_string () {
    local path_string="$@"

    # Expand to full name of home
    path_string=$(echo $path_string | sed -e "s%~%$HOME%g")
    path_string=$(echo $path_string | sed -e "s%\\$HOME%$HOME%g")

    # Remove trailing slash
    path_string=$(echo $path_string | sed -e "s%/$%%g")

    echo "${path_string}"
}

add_to_path () {
    local path_string="$@"

    if [ -z "${path_string}" ]; then
        return $(error 1 \
"add_to_path() must be called with a string of one or more \
directories to add to PATH")
    fi

    local OLD_IFS="${IFS}"
    IFS=":"

    local dir

    for dir in ${path_string}; do
        dir=$(sanitize_path_string "${dir}")
        local in_path=$(echo "${PATH}" | grep -E "${dir}:|${dir}\$")

        debug "Current PATH: ${PATH}"

        if [ -d "${dir}" ] && [ -z "${in_path}" ]; then
            debug "Adding ${dir} to PATH"
            PATH=${dir}${PATH:+:$PATH}
        fi
    done

    IFS=${OLD_IFS}

    export PATH
}
