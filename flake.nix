{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; # Nix Packages (Default)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # MacOS Package Management
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

    agenix.url = "github:ryantm/agenix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs,
      home-manager,
      darwin,
      catppuccin,
      agenix,
      sops-nix,
      determinate,
      nix-homebrew,
      ...
    }@inputs:
    let
      vars = {
        user = "moritzzmn";
        home-dir = "/Users/moritzzmn/";
        dotfile-path = "/Users/moritzzmn/.dotfile";
        host = "imbp";
        terminal = "ghostty";
        editor = "nvim";
        platform = "x86_64-darwin";
      };
      xucxich = {
        user = "xucxich";
        host = "xucxich";
        editor = "nvim";
        platform = "x86_64-linux";
      };
    in
    {
      darwinConfigurations = (
        import ./host/imbp/default.nix {
          inherit (nixpkgs) lib;
          inherit
            self
            inputs
            darwin
            vars
            nixpkgs
            nixpkgs-unstable
            home-manager
            catppuccin
            sops-nix
            nix-homebrew
            ;
        }
      );

      nixosConfigurations = (
        import ./host/xucxich/default.nix {
          inherit (nixpkgs) lib;
          inherit
            self
            inputs
            nixpkgs
            nixpkgs-unstable
            xucxich
            agenix
            sops-nix
            determinate
            ;
        }
      );
    };
}
