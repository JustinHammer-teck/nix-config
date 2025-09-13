{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}:
{
  imports = import ./../../darwin/modules;

  config = {

    aerospace.enable = true;
    tailscale.enable = true;

    environment = {
      shells = with pkgs; [ zsh ];
      systemPackages = with pkgs; [
        nixfmt-rfc-style
        nixd
        just

        pkgs-unstable.raycast
        pkgs-unstable.neovim
        pkgs-unstable.localsend
      ];

      variables = {
        NIXD_PATH = "${pkgs.nixd}/bin/nixd";
        EDITOR = "${vars.editor}";
        VISUAL = "${vars.terminal}";
      };
    };
  };
}
