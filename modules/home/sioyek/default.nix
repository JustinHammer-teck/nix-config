{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.application.sioyek;
in
{
  options.programs.application.sioyek = {
    enable = mkEnableOption "sioyek";
  };
  config = mkIf cfg.enable {
    programs.sioyek = {
      enable = true;
      package = pkgs.sioyek;
      config = {
        ui_font = "DroidSansM Nerd Font Mono";
        font_size = 15;
      };
    };
  };
}
