# Git
#

{
  programs.git = {
    enable = true;
    aliases = { gsw = "git switch"; };
    hooks = { pre-commit = ./pre-commit-script; };
  };
}
