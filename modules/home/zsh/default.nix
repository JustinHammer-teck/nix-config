{
  lib,
  config,
  vars,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.shell.zsh;
in
{
  options.shell.zsh = {
    enable = mkEnableOption "zsh";
  };
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      history = {
        append = true;
        ignoreDups = true;
        saveNoDups = true;
      };
    };
  };
}
