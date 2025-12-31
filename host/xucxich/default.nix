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
    user = "xucxich";
    host = "xucxich";
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
  modules = with inputs; [
    ./configuration.nix
  ];
}
