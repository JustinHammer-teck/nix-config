{ pkgs, pkgs-unstable, config, lib, vars, ... }: {
  config = {

    environment = {
      shells = with pkgs; [ zsh ];
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      systemPackages = with pkgs; [
        neovim
        bat
        git
        ripgrep
        jq
        starship
        nil
        eza
        delta
        nixfmt
        zoxide
        tailscale

        pkgs-unstable.podman
        pkgs-unstable.podman-compose
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

  };
}
