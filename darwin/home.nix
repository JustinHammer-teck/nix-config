{ config, pkgs, vars, ... }: 
  # This is required information for home-manager to do its job
let
 

in  {
  imports = [
    ./modules/skhd
    ./../modules/home/cli/programs/terminal/starship
    ./../modules/home/cli/programs/terminal/zellij
    ./../modules/home/cli/programs/direnv
  ];

  config = {
    home = {
      stateVersion = "24.05";
      username = "${vars.user}";
      homeDirectory = "${vars.home-dir}";
      packages = with pkgs; [starship bat ripgrep git yazi ];
      sessionVariables = { EDITOR = "${vars.editor}"; };
    };
    home.file = {
      ".config/wezterm".source = ~/DotFile/wezterm;
      ".config/aerospace".source = ~/DotFile/aerospace;
      ".config/nvim".source = ~/DotFile/nvim;
      ".config/yazi".source = ~/DotFile/yazi;
      ".config/zsh".source = ~/DotFile/zsh;
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
  };
}
