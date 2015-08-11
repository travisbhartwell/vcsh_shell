#! /usr/bin/env bash

set -eu -o pipefail
shopt -s nullglob

dir="$HOME/.cache/info"
mkdir -p "$dir"

now=$(date "+%s")
if [ -f "$dir/dir" ]; then
    mtime=$(stat --format="%Y" "$HOME/.cache/info/dir")
else
    mtime=0
fi
let age="$now - $mtime"
if [ $age -lt 21600 ]; then
    exit 0
fi

for i in $(IFS=:; echo $INFOPATH); do
    for j in "$i/"*; do
        if [[ "$j" =~ (-[0-9]+|/dir)$ ]]; then
            : ignore this file
        else
            install-info --quiet "$j" "$dir/dir"
        fi
    done
done
