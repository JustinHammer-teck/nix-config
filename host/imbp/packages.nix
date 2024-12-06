{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = import (./../../darwin/modules);

  config = {
    aerospace.enable = true;
    tailscale.enable = true;

    environment = {
      shells = with pkgs; [ zsh ];

      systemPackages = with pkgs; [
        mkalias
        nixfmt-rfc-style
        nixd

        pkgs-unstable.raycast
        pkgs-unstable.neovim
      ];

      variables = {
        #NIL_PATH = "${pkgs.nil}/bin/nil";
        NIXD_PATH = "${pkgs.nixd}/bin/nixd";
        EDITOR = "nvim";
        VISUAL = "wezterm";
      };
    };

    services = {
      nix-daemon.enable = true;
    };
  };
}
