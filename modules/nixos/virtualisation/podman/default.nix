{ pkgs, lib, config, ... }:
with lib;
let cfg = config.services.virtualisation.podman;
in {
  options.services.virtualisation.podman = {
    enable = mkEnableOption "Podman Support";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      podman = {
        enable = true;
        autoPrune = {
          enable = true;
          dates = "weekly";
          flags = [ "--filter=until-24h" "--filter=label!=important" ];
        };
        defaultNetwork.settings = { dns_enabled = true; };
      };
    };

    environment.systemPackages = with pkgs; [ dive podman-compose ];
  };
}
