{ pkgs, ... }: {
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "moritzzmn";
    homeDirectory = "/Users/moritzzmn/";
    packages = [
      pkgs.dotnet-sdk_8
      pkgs.msbuild
    ];
  };

  programs.home-manager.enable = true;

  programs.zsh.enable = true;
}

