{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Nix Packages (Default)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages
    #nixos-hardware.url = "github:NixOS/nixos-hardware";

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # MacOS Package Management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs-unstable, nixpkgs, home-manager, darwin, catppuccin, ... }@inputs:
    let
      vars = {
        user = "moritzzmn";
        home-dir = "/Users/moritzzmn/";
        host = "imbp";
        terminal = "wezterm";
        editor = "nvim";
        platform = "x86_64-darwin";
      };
    in {
      darwinConfigurations = (import ./host/imbp/default.nix {
        inherit (nixpkgs-unstable) lib;
        inherit  self inputs darwin vars nixpkgs-unstable nixpkgs home-manager catppuccin;
      });
      darwinPackages = self.darwinConfigurations."imbp".pkgs;
    };
}
