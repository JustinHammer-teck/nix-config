{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Nix Packages (Default)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # MacOS Package Management
    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix.url = "github:ryantm/agenix";
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
        deploy = "192.168.0.125";
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
            ;
        }
      );
    };
}
