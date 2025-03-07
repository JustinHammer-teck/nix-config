{
  vars,
  ...
}:
{
  config = {
    nixpkgs.hostPlatform = "${vars.platform}";
    # User configuration
    users.users.${vars.user} = {
      name = "${vars.user}";
      home = "${vars.home-dir}";
    };

    networking.computerName = "${vars.host}";
    networking.hostName = "${vars.host}";
    networking.localHostName = "${vars.host}";
  };
}
