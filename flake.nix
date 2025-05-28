{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; # Nix Packages (Default)
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

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
            ;
        }
      );
    };
}
