{ pkgs, ... }: {

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

      #stuff
      yabai
      skhd
    ];
    # environment variables
    variables = { NIL_PATH = "${pkgs.nil}/bin/nil"; };
  };

  services = {
    nix-daemon.enable = true;
    tailscale.enable = true;
    skhd.enable = true;
    yabai.enable = true;
  };
}
