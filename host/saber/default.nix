{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  nixos-hardware,
  lib,
  ...
}:
let
  vars = {
    user = "saber";
    host = "saber-tooth";
    home-dir = "/home/saber";
    dotfile-path = "/home/saber/.dotfile/";
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
      nixos-hardware
      lib
      vars
      ;
  };
  modules = [
    ./nix/substituter.nix

    ./configuration.nix

    nixos-hardware.nixosModules.apple-t2
    inputs.omarchy-nix.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
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
