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
    # Create /etc/zshrc that loads the nix-darwin environment.
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable= true;
    };
    home.file = {
      ".config/zsh".source = "${vars.dotfile-path}/zsh";
    };
  };
}
