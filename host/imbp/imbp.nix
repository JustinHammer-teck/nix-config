{ vars, pkgs, ... }:
{
  imports = [
    (import ./packages.nix)
    # (import ../../modules/darwin/zsh/default.nix)
  ];

  system = {
    checks.verifyNixPath = false;
    primaryUser = "${vars.user}";
  };

  nix.enable = false;

  nixpkgs.hostPlatform = "${vars.platform}";

  users.users.${vars.user} = {
    name = "${vars.user}";
    home = "${vars.home-dir}";
    shell = pkgs.zsh;
  };

  networking.computerName = "${vars.host}";
  networking.hostName = "${vars.host}";
  networking.localHostName = "${vars.host}";

  # programs.zsh = {
  #   enable = true;
  #   enableSyntaxHighlighting = true;
  #   enableCompletion = true;
  #   enableFzfHistory = true;
  #   shellInit = ''
  #     eval "$(starship init zsh)"
  #   '';
  # };
}
