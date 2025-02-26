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

    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs,
      home-manager,
      darwin,
      catppuccin,
      ...
    }@inputs:
    let
      vars = {
        user = "moritzzmn";
        home-dir = "/Users/moritzzmn/";
        dotfile-path = "/Users/moritzzmn/.dotfile";
        host = "imbp";
        terminal = "wezterm";
        editor = "nvim";
        platform = "x86_64-darwin";
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
            nixpkgs-unstable
            nixpkgs
            home-manager
            catppuccin
            ;
        }
      );
      darwinPackages = self.darwinConfigurations.${vars.host}.pkgs;
    };
}
