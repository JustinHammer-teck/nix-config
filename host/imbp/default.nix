{ self, inputs, nixpkgs-unstable, nixpkgs, home-manager, darwin, lib, ... }:
let
  vars = {
    user = "moritzzmn";
    home-dir = "/Users/moritzzmn/";
    dotfile-path = "/Users/moritzzmn/.dotfile";
    host = "imbp";
    terminal = "wezterm";
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
in {
  imbp = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = { inherit inputs self pkgs pkgs-unstable lib vars; };
    modules = [
      ./imbp.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.users.${vars.user} = { imports = [ ./home.nix ]; };
        home-manager.extraSpecialArgs = { inherit pkgs pkgs-unstable vars; };
      }
    ];
  };
}
