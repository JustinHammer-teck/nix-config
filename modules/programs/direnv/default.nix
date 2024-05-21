# Direnv
#  Create shell.nix
#  Create .envrc and add "use nix"
#  Add 'eval "$(direnv hook zsh)"' to .zshrc
#
{ pkgs, ...}:
{
  programs.direnv = {
    enable = true;
    package = pkgs.direnv;
    loadInNixShell = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
