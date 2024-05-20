{ pkgs, lib, config, ... }:

with lib;
let cfg = config.services.yabai;

in {
  options = { services.yabai = { enable = mkEnableOption "yabai"; }; };
  config = {
    home.file.".config.yabai.yabairc" = mkIf cfg.enable { source = ./yabairc; };
  };
}
