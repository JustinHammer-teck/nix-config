#!/bin/zsh

while getopts h: flag; do case "${flag}" in
    h) host=${OPTARG} ;;
esac done

nix run nixpkgs#nixos-rebuild -- \
    --option extra-substituters https://install.determinate.systems \
    --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM= \
    --fast \
    --build-host xucxich@xucxich \
    --target-host xucxich@xucxich \
    --use-remote-sudo \
    --flake .#xucxich \
    switch
