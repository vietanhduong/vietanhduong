#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)"

symlink() {
	if [ $# -lt 1 ]; then
		echo "[WARN] invalid args"
		return
	fi
	source="${SCRIPT_DIR}/$1"
	dest="$HOME/$1"
	
	if [[ -n "$2" ]]; then
		dest="$HOME/$2"
	fi

	mkdir -p $(dirname $dest)

	if [ -L "$dest" ]; then
		echo "[WARN] ${dest} already symlinked"
		return
	fi
	
	if [ -e "$dest" ]; then
        	echo "[ERROR] $dest exists but it's not a symlink. Please fix that manually"
        	exit 1
    	fi

	ln -s "$source" "$dest"
	
	echo "[INFO] $source -> $dest"
}

deploy() {
	for row in $(cat $SCRIPT_DIR/$1); do
		if [[ "$row" =~ ^#.* ]]; then
			continue
		fi

		source=$(echo $row | cut -d \| -f1)
		op=$(echo $row | cut -d \| -f2)
		dest=$(echo $row | cut -d \| -f3)

		case $op in
			s | soft)
				symlink $source $dest
				;;
			*)
				echo "[WARN] unknown operation $op. Skipping..."
				;;
		esac
	done
}

if [ -z "$@" ]; then
	echo "Usage: $(basename $0) <MANIFEST>"
	echo "Error: No MANIFEST file provided"
	exit 1
fi

deploy $1
