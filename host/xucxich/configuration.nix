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
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/virtualisation
  ];

  services.virtualisation.podman.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "xucxich";
    useDHCP = false;
    interfaces.wlo1 = {
      useDHCP = true;
      ipv4.addresses = [
        {
          address = "192.168.0.133";
          prefixLength = 24;
        }
      ];
    };
    ## defaultGateway = {
    ##   address = "192.168.0.1";
    ##   interface = "wlo1";
    ## };
  };
  # networking.supplicant = {
  #   "wlo1" = {
  #     configFile.path = "/etc/wpa_supplicant.conf";
  #     userControlled.group = "network";
  #     extraConf = ''
  #       ap_scan=1
  #       p2p_disabled=1
  #     '';
  #     extraCmdArgs = "-u -W";
  #     bridge = "br0";
  #   };
  # };

  # Pick only one of the below networking options.
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  networking.wireless.networks = {
    TelstraD3ADC8 = {
      pskRaw = "7df08cb5841804118bcbe9ee72b5fff983c6f7ba533b47e7ce363258273283f5";
    };
  };
  networking.networkmanager.enable = false; # Easiest to use and most distros use this by default.

  ## Firewall setup & Hardening System
  systemd.coredump.enable = false;
  systemd.user.services.pi-macvlanshim = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "Pihole Macvlan Shim";
    serviceConfig = {
      Type = "simple";
      ExecStart = ''/home/xucxich/services/pihole/pi-macvlanshim.sh'';
    };
  };
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    allowSFTP = false;
    ports = [ 22 ];

    settings = {
      LogLevel = "VERBOSE";
      AllowUsers = [ "xucxich" ];
      PasswordAuthentication = false;
      X11Forwarding = false;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "no";
    };

    extraConfig = ''
      ClientAliveCountMax 0
      ClientAliveInterval 300

      AllowTcpForwarding no
      AllowAgentForwarding no
      MaxAuthTries 3
      MaxSessions 2
      TCPKeepAlive no
    '';
  };

  services.fail2ban = {
    enable = false;
    maxretry = 10;
    bantime-increment.enable = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall = {
    enable = false;

    #allow traffic from tailscale
    trustedInterfaces = [
      "tailscale0"
      "wlo1"
    ];

    allowedTCPPorts = [ 22 ];

    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.xucxich = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "podman"
      ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILqP1HvcppNVOVZn/B3hd6He1ibPsTisvL16su7k9/7k moritzzmn@imbp"
      ];
    };
  };

  # security.sudo.extraRules = [
  #   {
  #     users = [ "xucxich" ];
  #     commands = [
  #       {
  #         command = "ALL";
  #         options = [ "NOPASSWD" ];
  #       }
  #     ];
  #   }
  # ];

  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    htop
    age
    sops
    git
    tree
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  # Flake support enable
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
  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
