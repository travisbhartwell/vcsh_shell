# TODO: Use tput instead of escape sequences

debug "Sourcing ~/.shellrc.d/01-colors.bash"

function _normal()
{
    if [ $# -lt 1 ]; then
        return 1
    fi

    local key="$1"
    echo "${__normal_colors[${key}]}"
}

function _bold()
{
    if [ $# -lt 1 ]; then
        return 1
    fi

    local key="$1"
    echo "${__bold_colors[${key}]}"
}

function __set_normal_color_value()
{
    if [ $# -lt 2 ]; then
        return 1
    fi

    local key="$1"
    local value="$2"
    __normal_colors["${key}"]="${value}"
}

function __set_bold_color_value()
{
    if [ $# -lt 2 ]; then
        return 1
    fi

    local key="$1"
    local value="$2"
    __bold_colors["${key}"]="${value}"
}

esc=""

_set_title="${esc}]0;"
_end_set_title=""

_reset="${esc}[00m"

export esc _set_title _end_set_title _reset

blackf=0
redf=1
greenf=2
yellowf=3
bluef=4
purplef=5
cyanf=6
whitef=7

export blackf redf greenf yellowf bluef purplef cyanf whitef

# Foreground colors
__set_normal_color_value "${blackf}" "${esc}[0;30m"
__set_normal_color_value "${redf}" "${esc}[0;31m"
__set_normal_color_value "${greenf}" "${esc}[0;32m"
__set_normal_color_value "${yellowf}" "${esc}[0;33m"
__set_normal_color_value "${bluef}" "${esc}[0;34m"
__set_normal_color_value "${purplef}" "${esc}[0;35m"
__set_normal_color_value "${cyanf}" "${esc}[0;36m"
__set_normal_color_value "${whitef}" "${esc}[0;37m"

__set_bold_color_value "${blackf}" "${esc}[01;30m"
__set_bold_color_value "${redf}" "${esc}[01;31m"
__set_bold_color_value "${greenf}" "${esc}[01;32m"
__set_bold_color_value "${yellowf}" "${esc}[01;33m"
__set_bold_color_value "${bluef}" "${esc}[01;34m"
__set_bold_color_value "${purplef}" "${esc}[01;35m"
__set_bold_color_value "${cyanf}" "${esc}[01;36m"
__set_bold_color_value "${whitef}" "${esc}[01;37m"
