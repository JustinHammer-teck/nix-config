{
  lib,
  config,
  pkgs-unstable,
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
      package = pkgs-unstable.sioyek;
    };
  };
}
