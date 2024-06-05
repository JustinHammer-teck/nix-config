#!/usr/bin/env zsh

if [ ! -z $1 ]; then
	export HOST=$1
else
	export HOST=$(hostname)
fi

darwin-rebuild switch --flake .#imbp --show-trace --impure
