{
  config,
  pkgs,
  vars,
  ...
}:
# This is required information for home-manager to do its job
let
in
{
  imports = [
    ./../modules/home/cli/programs/terminal/starship
    ./../modules/home/cli/programs/terminal/zellij
    ./../modules/home/cli/programs/direnv
  ];

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

        # Applications
        aerospace

        # Developer Tools
        vscodium
      ];
      sessionVariables = {
        EDITOR = "${toString vars.editor}";
        HOME_MANAGER = "${pkgs.lib.makeLibraryPath [ pkgs.home-manager ]}";
      };
    };

    home.file = {
      ".config/wezterm".source = "${vars.dotfile-path}/wezterm";
      ".config/aerospace".source = "${vars.dotfile-path}/aerospace";
      ".config/zsh".source = "${vars.dotfile-path}/zsh";
      ".ideavimrc".text = builtins.readFile "${vars.dotfile-path}/.ideavimrc";
    };

    programs.home-manager.enable = true;

    programs = {
      cli.terminal.zellij.enable = true;
      cli.terminal.starship.enable = true;
    };

    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
    };

    xdg.configFile.nvim = {
      source = config.lib.file.mkOutOfStoreSymlink "${vars.dotfile-path}/nvim";
      recursive = true;
    };
  };
}
