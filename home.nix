{ pkgs, ... }: {
  # This is required information for home-manager to do its job
  home = {
    stateVersion = "23.11";
    username = "moritzzmn";
    homeDirectory = "/Users/moritzzmn/";
    # packages = [ pkgs.dotnet-sdk_8 pkgs.msbuild pkgs.omnisharp-roslyn ];
    # sessionVariables = {
    #   OMNISHARP_PATH = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
    # };
  };

  programs.home-manager.enable = true;
  programs.direnv.enable = true;
}

