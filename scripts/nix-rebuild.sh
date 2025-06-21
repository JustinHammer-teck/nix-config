sudo nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- \
    switch --flake \
    .#imbp --impure --fallback --show-trace
