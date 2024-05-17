{ pkgs, ... }: {

  environment = {
    shells = with pkgs; [ zsh ];
    # List packages installed in system profile. To search by name, run:
    # $ nix-env -qaP | grep wget
    systemPackages = with pkgs; [
      neovim
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
    variables = {
      NIL_PATH = "${pkgs.nil}/bin/nil";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  services = {
    nix-daemon.enable = true;
    tailscale.enable = true;
  };
}
