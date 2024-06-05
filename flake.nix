{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11"; # Nix Packages (Default)

    nixpkgs-unstable.url =
      "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # MacOS Package Management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib.url = "github:snowfallorg/lib/dev";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, darwin
    , snowfall-lib, microvm, catppuccin, ... }@inputs:
    let
      vars = {
        user = "moritzzmn";
        home-dir = "/Users/moritzzmn/";
        terminal = "wezterm";
        editor = "nvim";
      };
    in {
      darwinConfigurations = (import ./host/imbp/default.nix {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs-unstable darwin vars snowfall-lib nixpkgs
          home-manager catppuccin;
      });
    };
}
