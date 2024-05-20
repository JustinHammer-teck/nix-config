{ inputs, config, pkgs, lib, ... }: {
  # This is required information for home-manager to do its job

  imports = [
    ./modules/yabai
  ];

  config = {
    home = {
      stateVersion = "23.11";
      username = "moritzzmn";
      homeDirectory = "/Users/moritzzmn/";
      packages = with pkgs; [ yabai skhd zellij ];
    };

    programs = {
      home-manager.enable = true;
      direnv.enable = true;
      direnv.enableZshIntegration = true;
      direnv.nix-direnv.enable = true;
    };

    services.yabai.enable = true;

    #programs.tmux = {
    #  enable = true;
    #  terminal = "screen-256color";
    #  historyLimit = 100000;
    #  prefix = "C-s";
    #};
  };
}

