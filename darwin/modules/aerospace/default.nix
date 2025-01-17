{
  config,
  lib,
  vars,
  pkgs,
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
      home.packages = with pkgs; [
        aerospace
      ];
      home.file = {
        ".config/aerospace".source = "${vars.dotfile-path}/aerospace";
      };
    };
  };
}
