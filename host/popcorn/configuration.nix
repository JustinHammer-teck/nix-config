# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  vars,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/virtualisation
    ./syncthing.nix
  ];

  services.virtualisation.podman.enable = false;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.pam.sshAgentAuth.enable = true;

  networking.hostName = "popcorn";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  networking.firewall = {
    enable = true;

    trustedInterfaces = [
      "tailscale0"
      "enp2s0"
    ];

    allowedTCPPorts = [
      22
    ];

    allowedUDPPorts = [
      53
      config.services.tailscale.port
    ];
  };

  time.timeZone = "Australia/Sydney";

  users.users.moritzzmn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
      "networkmanager"
    ];
    packages = with pkgs; [
      tree
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqP1HvcppNVOVZn/B3hd6He1ibPsTisvL16su7k9/7k moritzzmn@imbp"
    ];
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl

    localsend
    tmux

    pkgs-unstable.floorp-bin
    pkgs-unstable.thunderbird-latest
    pkgs-unstable.vscodium

    pkgs-unstable.jetbrains.pycharm-professional
    pkgs-unstable.jetbrains.rider
  ];

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      # Nerd Fonts (choose your favorites)
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.droid-sans-mono

      # Chinese fonts (REQUIRED for Chinese characters)
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
    ];

    fontconfig = {
      defaultFonts = {
        # Nerd Font first, then Chinese font as fallback
        monospace = [
          "Droid Sans Mono Nerd Font"
          "Noto Sans Mono CJK SC" # SC = Simplified Chinese
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif"
          "Noto Serif CJK SC"
        ];
      };
    };
  };

  services.openssh = {
    enable = true;
    allowSFTP = false;
    ports = [ 22 ];

    settings = {
      LogLevel = "INFO";
      AllowUsers = [ "moritzzmn" ];
      PasswordAuthentication = true;
      X11Forwarding = false;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "no";
    };

    extraConfig = ''
      PubkeyAuthentication yes

      ClientAliveCountMax 10
      ClientAliveInterval 300

      AllowTcpForwarding yes
      AllowAgentForwarding no
      MaxAuthTries 3
      TCPKeepAlive yes
    '';
  };

  services.logind.extraConfig = ''
    KillUserProcesses=no
  '';

  services.tailscale = {
    enable = true;
    package = pkgs-unstable.tailscale;
    openFirewall = true;
  };

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

  system.stateVersion = "25.05"; # Did you read the comment?
}
