{
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    dive
    podman-compose
  ];
}
