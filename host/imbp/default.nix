{ inputs, nixpkgs-unstable, darwin, home-manager-unstable, ... }:

let
  system = "x86_64-darwin";
  pkgs = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  macbook = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs pkgs; };
    modules = [
      ./imbp.nix
      ./../../darwin/homebrew.nix
      ./../../darwin/packages.nix
      home-manager-unstable.darwinModules.home-manager
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