{ inputs, pkgs, ... }: {
  # This is required information for home-manager to do its job

  imports = [ 
    ./../modules/services/podman
    ./../modules/terminals/wezterm
  ];

  home = {
    stateVersion = "23.11";
    username = "moritzzmn";
    homeDirectory = "/Users/moritzzmn/";
    packages = with pkgs; [ dotnet-sdk_8 msbuild yabai skhd ];
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  services = {
    podman.enable = true;
  };

  terminals = {
    wezterm.enable = true;
  };

  #programs.tmux = {
  #  enable = true;
  #  terminal = "screen-256color";
  #  historyLimit = 100000;
  #  prefix = "C-s";
  #};
}

