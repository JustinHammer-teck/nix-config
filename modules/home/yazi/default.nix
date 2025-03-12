{
  lib,
  config,
  vars,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.cli.terminal.yazi;
in
{
  options.programs.cli.terminal.yazi = {
    enable = mkEnableOption "yazi";
  };
  config = mkIf cfg.enable {
    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.yazi;
    };

    home.file = {
      ".config/yazi".source = "${vars.dotfile-path}/yazi";
    };
  };
}
