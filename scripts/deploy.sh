#!/bin/zsh

while getopts h:u:ts: flag; do case "${flag}" in
    h) host=${OPTARG} ;;
    u) user=${OPTARG} ;;

esac done

NIX_SSHOPTS='-tt' nix run nixpkgs#nixos-rebuild -- \
  --fast \
  --build-host $user@$host \
  --target-host $user@$host \
  --use-remote-sudo \
  --flake .#$host \
  switch --fallback

