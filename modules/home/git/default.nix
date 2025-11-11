{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  name = "Moritz Zimmerman";
  email = "dinhnhattai.nguyen@hotmail.com";
  cfg = config.git;
in
{
  options.git = {
    enable = mkEnableOption "Git";
  };
  config = mkIf cfg.enable {
    programs.git = mkDefault {
      enable = true;
      package = pkgs.git;
      userName = name;
      userEmail = email;
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsTUWula6xGju3x3LyEJKxhYDW2BfLvt3wcIjVyY3hC dinhnhattai.nguyen@hotmail.com";
        signByDefault = true;
        format = "ssh";
      };
      ignores = [
        ".DS_Store"
        "node_modules"
        ".direnv"
        "result"
      ];
      aliases = {
        gsw = "git switch";
        prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      };
      extraConfig = {
        branch.autosetuprebase = "always";
        color.ui = true;
        github.user = "JustinHammer-teck";
        push.default = "tracking";
        rerere.enabled = true;
        init.defaultBranch = "main";
      };
    };
  };
}
