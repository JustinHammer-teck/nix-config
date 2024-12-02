{ self, inputs, nixpkgs-unstable, nixpkgs, home-manager, darwin, lib, vars, catppuccin,  ... }:
let
  system = "${vars.platform}";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  pkgs-unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  imbp = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs self pkgs pkgs-unstable lib vars; };
    modules = [
      ./imbp.nix
      ./../../darwin/homebrew.nix
      ./../../darwin/packages.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.moritzzmn = {
          imports = [
            ./../../darwin/home.nix
            catppuccin.homeManagerModules.catppuccin
          ];
        };
        home-manager.extraSpecialArgs = { inherit vars; };
      }
    ];
  };
}