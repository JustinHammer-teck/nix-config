# Podman
#

{ pkgs-unstable, vars, lib, ... }:
with lib;
let cfg = config.virtualisation.podman;
in {
  options.virtualisation.podman = { enable = mkEnableOption "Podman"; };
  config = mkIf cfg.enable {
    virtualisation = {
      podman.enable = true;
      podman.dockerSocket.enable = true;
      podman.dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      podman.defaultNetwork.settings.dns_enabled = true;
    };

    users.groups.podman.members = [ "${vars.user}" ];

    environment.systemPackages = with pkgs-unstable; [
      podman # Containers
      podman-compose # Multi-Container
    ];
  };
}
