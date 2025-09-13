{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:

with lib;
let
  cfg = config.tailscale;
in
{
  options.tailscale = {
    enable = mkEnableOption "Tailscale VPN";
  };
  config = mkIf (cfg.enable) {

    services.tailscale = {
      enable = true;
      package = pkgs.tailscale;
    };
  };
}
