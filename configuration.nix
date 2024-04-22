# configuration.nix

{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.neovim
    pkgs.podman
    pkgs.podman-compose
    pkgs.qemu
    pkgs.bat
    pkgs.git
    pkgs.ripgrep
    pkgs.direnv
    pkgs.jq
    pkgs.starship
    pkgs.nil
    pkgs.eza
    pkgs.delta
    pkgs.nixfmt-classic
    pkgs.zoxide
    pkgs.gnupg # Encryption
  ];

  # environment variables
  environment.variables = { NIL_PATH = "${pkgs.nil}/bin/nil"; };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  #services.karabiner-elements.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "x86_64-darwin";

  users.users.moritzzmn = {
    name = "moritzzmn";
    home = "/Users/moritzzmn/";
  };

  # Optimize Nix storage 
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 0;
      Minute = 0;
    };
    options = "--delete-older-than 15d";
  };
}
