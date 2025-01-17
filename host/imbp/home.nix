{
  config,
  pkgs,
  vars,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  imports = import (./../../modules/home);
  config = {
    home = {
      stateVersion = "24.05";
      username = "${toString vars.user}";
      homeDirectory = "${toString vars.home-dir}";
      packages = with pkgs; [
        # CLI application
        starship
        bat
        ripgrep
        lazygit
        eza
        delta
        zoxide
        just
        yazi
        fzf

        # Applications
        # aerospace

        # Developer Tools
        vscodium
      ];
      sessionVariables = {
        EDITOR = "${toString vars.editor}";
        HOME_MANAGER = "${pkgs.lib.makeLibraryPath [ pkgs.home-manager ]}";
      };
    };

    home.file = {
      ".ideavimrc".text = builtins.readFile "${vars.dotfile-path}/.ideavimrc";
    };

    programs.home-manager.enable = true;

    git.enable = true;

    programs = {
      cli.terminal.wezterm.enable = true;
      cli.terminal.zellij.enable = true;
      cli.terminal.starship.enable = true;
      shell.zsh.enable = true;
    };

    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
    };

    xdg.configFile = {
      nvim = {
        source = mkOutOfStoreSymlink "${vars.dotfile-path}/nvim";
        recursive = true;
      };
      ghostty = {
        source = mkOutOfStoreSymlink "${vars.dotfile-path}/ghostty";
      };
    };
  };
}
