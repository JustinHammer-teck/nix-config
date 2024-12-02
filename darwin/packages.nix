{ pkgs, pkgs-unstable, config, lib, vars, ... }: {
  imports = [];
  config = {
    environment = {
      shells = with pkgs; [ zsh ];
    
      systemPackages = with pkgs; [
        git
        mkalias
        pkgs-unstable.raycast
        pkgs-unstable.neovim
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

    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableSyntaxHighlighting = true;
    };
  };
}
