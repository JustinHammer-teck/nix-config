{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; # Nix Packages (Default)
    nixpkgs-unstable.url =
      "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    felixkratz-formulae = {
      url = "github:FelixKratz/homebrew-formulae";
      flake = false;
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    omarchy-nix = {
      url = "github:henrysipp/omarchy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    agenix.url = "github:ryantm/agenix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs-unstable, nixpkgs, home-manager, darwin
    , nix-homebrew, ... }@inputs: {
      darwinConfigurations = (import ./host/imbp/default.nix {
        inherit (nixpkgs) lib;
        inherit self inputs darwin nixpkgs nixpkgs-unstable home-manager
          nix-homebrew;
      });

      nixosConfigurations.xucxich = (import ./host/xucxich/default.nix {
        inherit (nixpkgs) lib;
        inherit self inputs nixpkgs nixpkgs-unstable;
      });

      nixosConfigurations.popcorn = (import ./host/popcorn/default.nix {
        inherit (nixpkgs) lib;
        inherit self inputs nixpkgs nixpkgs-unstable;
      });
    };
}
