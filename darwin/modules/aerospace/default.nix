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

    services.aerospace = {
      enable = true;
      package = pkgs.aerospace;
    };
    home-manager.users.${vars.user} = {
      home.file = {
        ".config/aerospace".source = "${vars.dotfile-path}/aerospace";
      };
    };
  };
}
