{ pkgs, pkgs-unstable, vars, ... }: {
  imports = [
    (import ../../modules/darwin/default.nix)
    (import ./../../darwin/homebrew.nix)
    (import ./../../darwin/default.nix)
  ];

  aerospace.enable = true;
  tailscale.enable = true;

  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      just

      pkgs-unstable.raycast
      pkgs-unstable.neovim
      pkgs-unstable.localsend
    ];

    variables = {
      EDITOR = "${vars.editor}";
      VISUAL = "${vars.terminal}";
    };
  };
}
