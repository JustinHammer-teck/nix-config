# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/virtualisation
  ];

  services.virtualisation.podman.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "xucxich";
    interfaces.eno2 = {
      useDHCP = true;
      ipv4.addresses = [
        {
          address = "192.168.1.101";
          prefixLength = 24;
        }
      ];
    };
  };
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  systemd.coredump.enable = false;
  services.openssh = {
    enable = true;
    allowSFTP = false;
    ports = [ 22 ];

    settings = {
      LogLevel = "INFO";
      AllowUsers = [ "xucxich" ];
      PasswordAuthentication = true;
      X11Forwarding = false;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "no";
    };

    extraConfig = ''
      PubkeyAuthentication yes
      ClientAliveInterval 300
      AllowTcpForwarding no
      AllowAgentForwarding no
      MaxAuthTries 3
      TCPKeepAlive yes
    '';
  };

  security.pam.sshAgentAuth.enable = true;
  networking.firewall = {
    enable = false;

    trustedInterfaces = [
      "tailscale0"
      "wlo1"
      "eno2"
    ];

    allowedTCPPorts = [
      22
    ];

    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  time.timeZone = "Australia/Sydney";

  users = {
    users.xucxich = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "podman"
      ];

      packages = with pkgs; [
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqP1HvcppNVOVZn/B3hd6He1ibPsTisvL16su7k9/7k moritzzmn@imbp"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    htop
    git
    tree
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  services.logind.extraConfig = ''
    KillUserProcesses=no
  '';

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 15d";
    };
    optimise.automatic = true;
  };

  services = {
    tailscale = {
      enable = true;
      package = pkgs.tailscale;
      extraSetFlags = [
        "--advertise-exit-node"
      ];
      extraUpFlags = [ "--ssh" ];
      useRoutingFeatures = "both";
    };
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
