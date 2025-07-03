#!/bin/zsh

while getopts h:u:ts: flag; do case "${flag}" in
    h) host=${OPTARG} ;;
    u) user=${OPTARG} ;;

esac done

# if ts then
# echo "
# nix run nixpkgs#nixos-rebuild -- \
#     --option extra-substituters https://install.determinate.systems \
#     --option extra-trusted-public-keys cache.flakehub.com-3:hjuill5svk4ikm86jzgdxw12y2hwd5g07qkthtocdcm= \
#     --fast \
#     --build-host $user@$host \
#     --target-host $user@$host \
#     --use-remote-sudo \
#     --flake .#$user \
#     switch "
# fi
#
# export NIX_SSHOPTS="-tt";
nix run nixpkgs#nixos-rebuild -- \
    --option extra-substituters https://install.determinate.systems \
    --option extra-trusted-public-keys cache.flakehub.com-3:hjuill5svk4ikm86jzgdxw12y2hwd5g07qkthtocdcm= \
    --fast \
    --build-host $user@$host \
    --target-host $user@$host \
    --use-remote-sudo \
    --flake .#$user \
    switch --impure

