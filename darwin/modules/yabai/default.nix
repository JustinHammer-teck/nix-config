{ pkgs, lib, config, vars, ... }:

with lib;

let cfg = config.services.desktops.yabai;
in {
  options.services.desktops.yabai = { enable = mkEnableOption "yabai"; };
  config = mkIf cfg.enable {
    services.yabai = {
      enable = true;
      package = pkgs.yabai;
      extraConfig = builtins.readFile "${vars.home-dir}/.config/yabai/yabairc";
    };
  };
}
