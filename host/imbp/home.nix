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
    xdg.enable = true;
    home = {
      stateVersion = "25.05";
      username = "${toString vars.user}";
      homeDirectory = "${toString vars.home-dir}";
      packages = with pkgs; [
        starship
        bat
        lazygit
        delta
        just
        fzf
        ripgrep

        iperf

        pkgs-unstable.docker
        pkgs-unstable.docker-compose

        age
        pkgs-unstable.sops

        tree

        # Applications
        pkgs-unstable.thunderbird-latest-unwrapped
        pkgs-unstable.brave
        pkgs-unstable.claude-code
        pkgs-unstable.insomnia
      ];

      sessionVariables = {
        EDITOR = "${toString vars.editor}";
        HOME_MANAGER = "${pkgs.lib.makeLibraryPath [ pkgs.home-manager ]}";
      };
      shell.enableZshIntegration = true;
    };

    git.enable = true;

    programs.zoxide = {
      package = pkgs.zoxide;
      enable = true;
      enableZshIntegration = true;
    };

    programs.eza = {
      package = pkgs.eza;
      enable = true;
      enableZshIntegration = true;
      icons = "always";
      git = true;
      colors = "always";
      extraOptions = [
        "--group-directories-first"
        "--long"
        "--accessed"
        "--no-time"
      ];
    };

    programs.atuin = {
      enable = true;
      package = pkgs.atuin;
      enableZshIntegration = true;
    };

    programs = {
      cli.terminal.starship.enable = true;
      shell.zsh.enable = true;
    };

    home.file = {
      ".ideavimrc".text = builtins.readFile "${vars.dotfile-path}/.ideavimrc";
      ".config/eza".source = "${vars.dotfile-path}/eza";
    };

    xdg.configFile = {
      nvim = {
        source = mkOutOfStoreSymlink "${vars.dotfile-path}/nvim";
        recursive = true;
      };
      wezterm = {
        source = mkOutOfStoreSymlink "${vars.dotfile-path}/wezterm";
        recursive = true;
      };
    };
  };
}
