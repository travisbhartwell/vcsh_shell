debug "Sourcing ~/.shellrc.d/common/nix.bash"

function __nix_prompt_fn()
{
    if [ -n "${IN_NIX_SHELL}" ]; then
        echo -ne '\[$(_normal ${yellowf})\][NIX SHELL]\[${_reset}\]'
    fi
}

__add_new_prompt_fn __nix_prompt_fn

# Useful functions and aliases
# Given an executable from $PATH, cd to the package top-level directory
# in the Nix store
function cd_nix_package_for_file_dir()
{
    if [ "$#" -ne 1 ]; then
        return $(error 2 "${FUNCNAME} requires a single parameter, \
a file on the path.")
    fi

    local f="${1}"
    local fpath="$(which ${f} 2> /dev/null)"

    if [ -n "${fpath}" ]; then
        local pkgpath="$(readlink -nf ${fpath} | grep -o '/nix/store/[^/]*')"

        if [ -n "${pkgpath}" ]; then
            cd "${pkgpath}"
        else
            return $(error 2 "${f} not in a package.")
        fi
    else
        return $(error 2 "${f} not found.")
    fi
}

# Get the location in the store where .nix files are
function get_nixpkgs_dir()
{
    # Assume the package exists
    echo $(readlink -nf ${HOME}/.nix-defexpr/channels_root/nixos/nixpkgs)
}

# cd to the location in the store where .nix files are
function cd_nixpkgs_dir()
{
    local nixpkgs_dir=$(get_nixpkgs_dir)

    cd "${nixpkgs_dir}"
}

# Find a file in the nixpkgs directory of the store
function find_file_in_nixpkgs()
{
    local nixpkgs_dir=$(get_nixpkgs_dir)

    find "${nixpkgs_dir}" ${*}
}

# Search, using ag, the files in the nixpkgs directory of the store
function search_nixpkgs()
{
    local nixpkgs_dir=$(get_nixpkgs_dir)

    ag ${*} "${nixpkgs_dir}"
}
