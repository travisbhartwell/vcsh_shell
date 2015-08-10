# Call the script to update the info dirs

debug "Sourcing ~/.profile/10-info.sh"

$HOME/.profile.d/common/update-info-dirs.bash

export INFOPATH="$HOME/.cache/info:$INFOPATH"

