#!/bin/zsh

while getopts h:u:ts: flag; do case "${flag}" in
    h) host=${OPTARG} ;;
    u) user=${OPTARG} ;;

esac done

NIX_SSHOPTS=-tt sudo nix run nixpkgs#nixos-rebuild -- \
  --option extra-substituters https://install.determinate.systems \
  --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM= \
  --fast \
  --build-host $user@$host \
  --target-host $user@$host \
  --use-remote-sudo \
  --flake .#$host \
  switch --impure

