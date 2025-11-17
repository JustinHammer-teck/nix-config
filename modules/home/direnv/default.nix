{ pkgs, ... }: {
  config = {
    programs.direnv = {
      enable = true;
      package = pkgs.direnv;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
  };
}
