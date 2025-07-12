{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  lib,
  ...
}:
let
  xucxich = {
    user = "xucxich";
    host = "xucxich";
    editor = "vim";
    platform = "x86_64-linux";
  };

  system = "${xucxich.platform}";
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
      xucxich
      ;
  };
  modules = with inputs; [
    ./configuration.nix
    ./hardware-configuration.nix
    agenix.nixosModules.default
    determinate.nixosModules.default
  ];
}
