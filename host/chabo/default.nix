{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  lib,
  chabo,
  agenix,
  determinate,
  ...
}:
let
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
{
  nixpkgs.lib.nixosSystem = {
    inherit system;
    specialArgs = {
      inherit
        inputs
        self
        pkgs
        pkgs-unstable
        lib
        chabo
        agenix
        determinate
        ;
    };
    modules = [
      ./configuration.nix
      ./hardware-configuration.nix
      agenix.nixosModules.default
      determinate.nixosModules.default
    ];
  };
}
