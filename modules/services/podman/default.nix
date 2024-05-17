{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.moritzzmn; let
  cfg = config.services.podman;
in {
  options.services.podman = with types; {
    enable = mkBoolOpt false "Whether or not to manage podman";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      podman-compose
    ];
  };
}
