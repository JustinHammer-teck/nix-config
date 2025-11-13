{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  lib,
  ...
}:
let
  vars = {
    user = "moritzzmn";
    host = "popcorn";
    home-dir = "/home/moritzzmn";
    dotfile-path = "/home/moritzzmn/.dotfile/";
    editor = "nvim";
    platform = "x86_64-linux";
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
nixpkgs.lib.nixosSystem {
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
    ./configuration.nix
    ./hardware-configuration.nix
    ./omarchy.nix
    inputs.omarchy-nix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    inputs.determinate.nixosModules.default
    {
      home-manager = {
        users."${vars.user}" = {
          imports = [
            ./home.nix
            inputs.omarchy-nix.homeManagerModules.default
          ];
        };
        extraSpecialArgs = {
          inherit
            pkgs
            pkgs-unstable
            vars
            inputs
            ;
        };
      };
    }
  ];
}
