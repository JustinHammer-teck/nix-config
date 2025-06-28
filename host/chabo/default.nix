{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  lib,
  ...
}:
let
  chabo = {
    user = "chabo";
    host = "chabo";
    editor = "vim";
    platform = "x86_64-linux";
  };

  system = "${chabo.platform}";

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
      chabo
      ;
  };
  modules = [
    ./configuration.nix
    ./hardware-configuration.nix
    inputs.agenix.nixosModules.default
    inputs.determinate.nixosModules.default
  ];
}
