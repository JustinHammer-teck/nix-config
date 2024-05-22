{ pkgs, pkgs-unstable, vars, lib, config, ... }:
with lib;
let cfg = config.services.virtualisation.podman;
in {
  options.services.virtualisation.podman = {
    enable = mkEnableOption "Podman";
  };
  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        dockerSocket.enable = true;
        dockerCompat = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    environment.systemPackages = with pkgs-unstable; [
      podman # Containers
      podman-compose # Multi-Container
    ];
  };
}

