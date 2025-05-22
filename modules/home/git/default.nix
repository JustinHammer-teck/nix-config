{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  name = "Moritz Zimmermann";
  email = "dinhnhattai.nguyen@hotmail.com";
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
      ignores = [
        ".DS_Store"
        "node_modules"
        ".direnv"
        "result"
      ];
      aliases = {
        gsw = "git switch";
      };
      extraConfig = {
        pull.rebase = true;
        commit.gpgSign = lib.mkDefault true;
        gpg.format = "ssh";
        user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICsTUWula6xGju3x3LyEJKxhYDW2BfLvt3wcIjVyY3hC dinhnhattai.nguyen@hotmail.com";
        gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";

        push.autoSetupRemote = true;
        rerere.enabled = true;
      };
    };
  };
}
