{ config, pkgs, vars, ... }: {
  # This is required information for home-manager to do its job

  imports = [
    ./../modules/home/cli/programs/terminal/starship
    ./../modules/home/cli/programs/terminal/zellij
    ./../modules/home/cli/programs/direnv
  ];

  config = {
    home = {
      stateVersion = "23.11";
      username = "${vars.user}";
      homeDirectory = "${vars.home-dir}";
      packages = with pkgs; [ skhd ];
    };

    programs.home-manager.enable = true;
    programs.terminal.zellij.enable = true;
    programs.cli.terminal.starship.enable = true;
  };
}

