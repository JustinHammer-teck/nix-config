# configuration.nix

{ pkgs, ... }: {

  imports = [
    ./modules/yabai
    ./modules/skhd
  ];

  # User configuration
  users.users.moritzzmn = {
    name = "moritzzmn";
    home = "/Users/moritzzmn/";
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

  # Optimize Nix storage 
  nix = {
    settings = {
      auto-optimise-store = true;
      # Necessary for using flakes on this system.
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
