{ pkgs, lib, config, vars, ... }:

with lib;
let cfg = config.services.yabai;
in {
  options.services.yabai = { enable = mkEnableOption "yabai"; };
  config = mkIf cfg.enable {
    services.yabai = {
      enable = true;
      package = pkgs.yabai;
      extraConfig = builtins.readFile "${vars.home-dir}/.config/yabai/yabairc";
    };
  };
}
