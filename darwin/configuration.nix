# configuration.nix

{ pkgs, ... }: {

  # User configuration
  users.users.moritzzmn = {
    name = "moritzzmn";
    home = "/Users/moritzzmn/";
  };

  environment = {
    shells = with pkgs; [ zsh ];
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = with pkgs; [
      neovim
      podman
      podman-compose
      qemu
      bat
      git
      ripgrep
      direnv
      jq
      starship
      nil
      eza
      delta
      nixfmt-classic
      zoxide
      gnupg # Encryption
      tailscale
      fastfetch
    ];
    # environment variables
    variables = { NIL_PATH = "${pkgs.nil}/bin/nil"; };
  };

  services = {
    nix-daemon.enable = true;
    tailscale.enable = true;
  };

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  security.pam.enableSudoTouchIdAuth = true;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  # Necessary for using flakes on this system.

  # Optimize Nix storage 
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
      interval.Day = 7;
      options = "--delete-older-than 7d";
    };
    extraOptions = ''
      auto-optimise-store = true
    '';
  };
}
