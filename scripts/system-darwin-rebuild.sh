#!/usr/bin/env zsh

if [ ! -z $1 ]; then
	export HOST=$1
else
	export HOST=$(hostname)
fi

sudo darwin-rebuild switch --flake .#imbp --impure
