{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  lib,
  xucxich,
  agenix,
  determinate,
  ...
}:
let
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
{
  xucxich = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit
        inputs
        self
        pkgs
        pkgs-unstable
        lib
        xucxich
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
