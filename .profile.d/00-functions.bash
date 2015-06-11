# Useful bash-specific functions needed for all invocations

debug "Sourcing ~/.profile.d/00-functions.bash"

fn_exists () {
    if [ -z "${1}" ]; then
        return $(error 1 \
"${FUNCNAME} requires a single parameter containing the name of \
the function to test for.")
    fi

    local fn_name="${1}"
    type "${fn_name}" > /dev/null 2>&1
}
