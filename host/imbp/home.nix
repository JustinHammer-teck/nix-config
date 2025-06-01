{
  config,
  pkgs,
  pkgs-unstable,
  vars,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  imports = import ./../../modules/home;
  config = {
    home = {
      stateVersion = "25.05";
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
        fzf

        # Secret
        age
        pkgs-unstable.sops

        # Developer Tools
        qemu
        _1password-cli
        tree

        # Applications
        pkgs-unstable.thunderbird-latest-unwrapped
        pkgs-unstable.brave

      ];
      sessionVariables = {
        EDITOR = "${toString vars.editor}";
        HOME_MANAGER = "${pkgs.lib.makeLibraryPath [ pkgs.home-manager ]}";
      };
    };

    programs.home-manager.enable = true;

    git.enable = true;

    programs = {
      application.sioyek.enable = true;
      cli.terminal.wezterm.enable = true;
      cli.terminal.zellij.enable = true;
      cli.terminal.starship.enable = true;
      cli.terminal.yazi.enable = true;
      shell.zsh.enable = true;
    };

    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
    };

    home.file = {
      ".ideavimrc".text = builtins.readFile "${vars.dotfile-path}/.ideavimrc";
      # ".config/1Password/ssh/".source = "${vars.dotfile-path}/1Password/ssh";
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
