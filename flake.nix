# flake.nix *
#   ├─ ./darwin
#   │   └─ default.nix
#

{
  description = "Nix, NixOS and Nix Darwin System Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11"; # Nix Packages (Default)

    nixpkgs-unstable.url =
      "github:nixos/nixpkgs/nixos-unstable"; # Unstable Nix Packages

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Unstable User Environment Manager
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # MacOS Package Management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    snowfall-lib.url = "github:snowfallorg/lib/dev";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager
    , home-manager-unstable, darwin, snowfall-lib, ...
    }@inputs: # Function telling flake which inputs to use
    let
      # Variables Used In Flake
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
          home-manager;
      });
    };
}
