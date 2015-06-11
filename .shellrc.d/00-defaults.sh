debug "Sourcing ~/.shellrc.d/00-defaults.sh"

EDITOR=emacs

ALTERNATE_EDITOR=
# Preferred order when Emacs isn't available
for e in vim vi nano ed; do
    epath=$(which "${e}" 2> /dev/null)

    if [ -x "${epath}" ]; then
        ALTERNATE_EDITOR="${epath}"
        break
    fi
done

export EDITOR ALTERNATE_EDITOR
