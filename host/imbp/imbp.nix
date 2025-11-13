{ vars, pkgs, ... }: {
  imports = [ (import ./packages.nix) ];
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
}
