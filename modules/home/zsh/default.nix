{
  lib,
  config,
  vars,
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
      enableCompletion = true;
      autosuggestion = {
        enable = true;
      };
      syntaxHighlighting.enable = true;
    };

    xdg.configFile = {
      zsh = {
        source = config.lib.file.mkOutOfStoreSymlink "${vars.dotfile-path}/zsh";
        recursive = true;
      };
    };
  };
}
