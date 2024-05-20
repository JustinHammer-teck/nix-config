{ inputs, nixpkgs-unstable, darwin, home-manager-unstable, nixpkgs, home-manager
, lib, ... }:

let
  system = "x86_64-darwin";
  pkgs = import nixpkgs { inherit system; };
  pkgs-unstable = import nixpkgs-unstable { inherit system; };
in {
  imbp = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs pkgs pkgs-unstable lib; };
    modules = [
      ./imbp.nix
      ./../../darwin/homebrew.nix
      ./../../darwin/packages.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.moritzzmn = import ./../../darwin/home.nix;
        # Optionally, use home-manager.extraSpecialArgs to pass
        # arguments to home.nix
      }
    ];
  };
}
