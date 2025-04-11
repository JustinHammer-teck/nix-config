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
  imports = import ./../../modules/home;
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
        fzf

        # Secret
        age
        sops

        # Developer Tools
        vscodium
        qemu
      ];
      sessionVariables = {
        EDITOR = "${toString vars.editor}";
        HOME_MANAGER = "${pkgs.lib.makeLibraryPath [ pkgs.home-manager ]}";
      };
    };

    programs.home-manager.enable = true;

    git.enable = true;

    programs = {
      # application.sioyek.enable = true;
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
