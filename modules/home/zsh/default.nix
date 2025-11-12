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
      syntaxHighlighting.enable = true;
      history = {
        append = true;
        ignoreDups = true;
        saveNoDups = true;
      };
    };
  };
}
