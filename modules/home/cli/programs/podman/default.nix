{ pkgs, pkgs-unstable, vars, lib, config, ... }:
with lib;
let cfg = config.cli.programs.podman;
in {
  options.cli.programs.podman = { enable = mkEnableOption "Podman Programs"; };
  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs-unstable; [
      podman # Containers
      podman-compose # Multi-Container
    ];
  };
}

