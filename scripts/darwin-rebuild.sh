sudo nix run nix-darwin/nix-darwin-25.11#darwin-rebuild -- \
    --option extra-substituters https://install.determinate.systems \
    --option extra-trusted-public-keys cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM= \
    switch --flake \
    .#imbp --impure --fallback --show-trace
