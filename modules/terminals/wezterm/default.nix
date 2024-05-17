{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.terminals.wezterm;
in {
  options.terminals.wezterm = {
    enable = mkEnableOption "enable wezterm terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./config.lua;
    };
  };
}
