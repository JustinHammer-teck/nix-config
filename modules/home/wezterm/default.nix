{
  config,
  lib,
  vars,
  ...
}:

with lib;
let
  cfg = config.programs.cli.terminal.wezterm;
in
{
  options.programs.cli.terminal.wezterm = {
    enable = mkEnableOption "Wezterm";
  };
  config = mkIf cfg.enable {
    home.file = {
      ".config/wezterm".source = "${vars.dotfile-path}/wezterm";
    };
  };
}
