{
  config,
  lib,
  vars,
  pkgs-unstable,
  ...
}:

with lib;
let
  cfg = config.aerospace;
in
{
  options.aerospace = {
    enable = mkEnableOption "Aerospace Titling Manager";
  };
  config = mkIf (cfg.enable) {
    home-manager.users.${vars.user} = {
      home.packages = with pkgs-unstable; [
        aerospace
      ];
      home.file = {
        ".config/aerospace".source = "${vars.dotfile-path}/aerospace";
      };
    };
  };
}
