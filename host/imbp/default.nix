{
  self,
  inputs,
  nixpkgs-unstable,
  nixpkgs,
  home-manager,
  darwin,
  lib,
  sops-nix,
  nix-homebrew,
  ...
}:
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

  system = "${vars.platform}";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;

  };
  pkgs-unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;

  };
in
{
  imbp = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {
      inherit
        inputs
        self
        pkgs
        pkgs-unstable
        lib
        vars
        ;
    };
    modules = [
      ./imbp.nix
      ./packages.nix
      ./../../darwin
      ./../../darwin/homebrew.nix
      sops-nix.darwinModules.sops
      nix-homebrew.darwinModules.nix-homebrew
      {
        nix-homebrew = {
          enable = true;
          user = "${vars.user}";
          taps = {
            "FelixKratz/homebrew-formulae" = inputs.felixkratz-formulae;
            "homebrew/homebrew-core" = inputs.homebrew-core;
            "homebrew/homebrew-cask" = inputs.homebrew-cask;
          };
          mutableTaps = true;
          autoMigrate = true;
        };
      }
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${vars.user} = {
          imports = [
            ./home.nix
            inputs.catppuccin.homeModules.catppuccin
          ];
        };
        home-manager.extraSpecialArgs = { inherit pkgs pkgs-unstable vars; };
      }
    ];
  };
}
