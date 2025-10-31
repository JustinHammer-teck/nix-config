{
  lib,
  config,
  vars,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.programs.shell.zsh;
in
{
  options.programs.shell.zsh = {
    enable = mkEnableOption "zsh";
  };
  config = mkIf cfg.enable {

    programs.zsh = {
      enable = true;
      enableCompletion = false;
      syntaxHighlighting.enable = true;
      # plugins = [
      #   {
      #     name = pkgs.zsh-autopair.pname;
      #     src = pkgs.zsh-autopair.src;
      #   }
      #   {
      #     name = pkgs.nix-zsh-completions.pname;
      #     src = pkgs.nix-zsh-completions.src;
      #   }
      #   {
      #     name = pkgs.zsh-you-should-use.pname;
      #     src = pkgs.zsh-you-should-use.src;
      #   }
      # ];
      history = {
        append = true;
        ignoreDups = true;
        saveNoDups = true;
      };
    };

    # xdg.configFile = {
    #   zsh = {
    #     source = config.lib.file.mkOutOfStoreSymlink "${vars.dotfile-path}/zsh";
    #     recursive = true;
    #   };
    # };
  };
}
