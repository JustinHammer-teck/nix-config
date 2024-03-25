{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }:
  {
    darwinConfigurations = {
      Moritzs-MBP = nix-darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./configuration.nix
          ./homebrew.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
