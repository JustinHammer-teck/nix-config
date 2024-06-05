{ config, pkgs, vars, ... }: {
  # This is required information for home-manager to do its job

  imports = [
    ./modules/skhd
    ./../modules/home/cli/programs/terminal/starship
    ./../modules/home/cli/programs/terminal/zellij
    ./../modules/home/cli/programs/direnv
  ];

  config = {
    home = {
      stateVersion = "23.11";
      username = "${vars.user}";
      homeDirectory = "${vars.home-dir}";
      packages = with pkgs; [ skhd starship bat ripgrep git ];
      sessionVariables = { EDITOR = "${vars.editor}"; };
    };

    programs.home-manager.enable = true;
    programs = {
      starship.enable = true;
      starship.enableZshIntegration = true;
      terminal.zellij.enable = true;
      cli.terminal.starship.enable = true;
    };

    services.desktops.skhd.enable = true;
  };
}

