{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  services.tailscale = {
    enable = true;
    package = pkgs-unstable.tailscale;
    openFirewall = true;
  };

  networking.firewall = {
    trustedInterfaces = [ "tailscale0" ];
    checkReversePath = "loose"; # required to connect to Tailscale exit nodes
  };
}
