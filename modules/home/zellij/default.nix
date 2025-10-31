{
  pkgs,
  lib,
  config,
  vars,
  ...
}:
with lib;
let
  cfg = config.programs.cli.terminal.zellij;
in
{
  options.programs.cli.terminal.zellij = {
    enable = mkEnableOption "Zellij";
  };
  config = mkIf cfg.enable {
    home.file = {
      ".config/zellij".source = "${vars.dotfile-path}/zellij";
    };
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.zellij;
    };
  };
}
