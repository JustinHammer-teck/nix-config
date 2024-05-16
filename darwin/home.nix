{ inputs, pkgs, ... }: {
  # This is required information for home-manager to do its job

  imports = [ 
    #./modules/yabai 
    ./modules/skhd 
    ./../modules/alacritty 
  ];

  home = {
    stateVersion = "23.11";
    username = "moritzzmn";
    homeDirectory = "/Users/moritzzmn/";
    packages = with pkgs; [ dotnet-sdk_8 msbuild yabai skhd alacritty ];
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;
  programs.direnv.nix-direnv.enable = true;

  services = {
   # yabai.enable = true;
    skhd.enable = false;
  };

  #programs.tmux = {
  #  enable = true;
  #  terminal = "screen-256color";
  #  historyLimit = 100000;
  #  prefix = "C-s";
  #};
}

