debug "Sourcing ~/.shellrc.d/10-less.sh"

if [ -n "$(which pygmentize)" ]; then
	LESS='-iXFR'
	LESSCOLORIZER='pygmentize -g'

	export LESS LESSCOLORIZER
fi
