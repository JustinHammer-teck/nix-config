{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  name = "Moritz Zimmermann";
  email = "81556222+JustinHammer-teck@users.noreply.github.com";
  cfg = config.git;
in
{
  options.git = {
    enable = mkEnableOption "Git";
  };
  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      package = pkgs.git;
      userName = name;
      userEmail = email;
      ignores = [ ".DS_Store" ];
      aliases = {
        gsw = "git switch";
      };
      extraConfig = {
        pull.rebase = true;
      };
    };

  };
}
