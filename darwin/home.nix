{ config, pkgs, vars, ... }: {
  # This is required information for home-manager to do its job

  imports = [
    ./../modules/services/yabai
    ./../modules/programs/terminal/zellij
    ./../modules/programs/direnv
  ] {inherit vars;};

  config = {
    home = {
      stateVersion = "23.11";
      username = "${vars.user}";
      homeDirectory = "${vars.home-dir}";
      packages = with pkgs; [ skhd direnv ];
    };

    programs.home-manager.enable = true;
    programs.terminal.zellij.enable = true;
    services.yabai.enable = true;

  };
}

