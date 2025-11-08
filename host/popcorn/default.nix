{
  self,
  inputs,
  nixpkgs,
  nixpkgs-unstable,
  lib,
  ...
}:
let
  popcorn = {
    user = "moritzzmn";
    host = "popcorn";
    editor = "nvim";
    platform = "x86_64-linux";
  };

  system = "${popcorn.platform}";

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
      popcorn
      ;
  };
  modules = [
    ./configuration.nix
    ./hardware-configuration.nix
    inputs.omarchy-nix.nixosModules.default
    inputs.determinate.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    {
      omarchy = {
        full_name = "Moritz Zimmerman";
        email_address = "dinhnhattai.nguyen@hotmail.com";
        theme = "everforest";
      };

      home-manager = {
        users."${popcorn.user}" = {
          imports = [ inputs.omarchy-nix.homeManagerModules.default ];
        };
      };
    }
  ];
}
