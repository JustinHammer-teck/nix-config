{
  vars,
  pkgs,
  ...
}:
{
  config = {

    nix = {
      package = pkgs.nix;
      settings = {
        trusted-users = [ "${vars.user}" ];
        substituters = [
          "https://nix-community.cachix.org"
          "https://cache.nixos.org"
        ];
        experimental-features = "nix-command flakes";
      };
      gc = {
        automatic = true;
        interval.Day = 7;
        options = "--delete-older-than 7d";
      };
      extraOptions = ''
        auto-optimise-store = true
      '';
    };

    nixpkgs.hostPlatform = "${vars.platform}";

    users.users.${vars.user} = {
      name = "${vars.user}";
      home = "${vars.home-dir}";
      shell = pkgs.zsh;
    };

    networking.computerName = "${vars.host}";
    networking.hostName = "${vars.host}";
    networking.localHostName = "${vars.host}";
  };
}
