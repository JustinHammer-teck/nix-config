{ pkgs, pkgs-unstable, config, lib, vars, ... }: {
  imports = [];
  config = {
    environment = {
      loginShell = pkgs.zsh;
      shells = with pkgs; [ zsh ];
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget

      systemPackages = with pkgs; [
        pkgs-unstable.neovim

        nil
        eza
        delta
        nixfmt-classic
        zoxide
        just
      ];

      variables = {
        NIL_PATH = "${pkgs.nil}/bin/nil";
        EDITOR = "nvim";
        VISUAL = "wezterm";
      };
    };

    services = {
      nix-daemon.enable = true;
    };

    services.tailscale = {
      enable = true;
      package = pkgs-unstable.tailscale;
    };

    # Create /etc/zshrc that loads the nix-darwin environment.
    #
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
    };
  };
}
