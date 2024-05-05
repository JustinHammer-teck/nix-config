{ inputs, pkgs, ... }: {
  # This is required information for home-manager to do its job

  home = {
    stateVersion = "23.11";
    username = "moritzzmn";
    homeDirectory = "/Users/moritzzmn/";
    packages = [ pkgs.dotnet-sdk_8 pkgs.msbuild pkgs.zellij ];
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  #programs.tmux = {
  #  enable = true;
  #  terminal = "screen-256color";
  #  historyLimit = 100000;
  #  prefix = "C-s";
  #};
}

