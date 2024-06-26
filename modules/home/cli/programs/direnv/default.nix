# Direnv
#  Create shell.nix
#  Create .envrc and add "use nix"
#  Add 'eval "$(direnv hook zsh)"' to .zshrc
#
{ pkgs, ... }: {
  config = {
    programs.direnv = {
      enable = true;
      package = pkgs.direnv;
      nix-direnv.enable = false;
      enableZshIntegration = true;
    };
  };
}
