{ vars, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "${vars.user}";
    dataDir = "${vars.home-dir}";
    extraFlags = [ "--no-default-folder" ];
    settings = {
      folders = {
        "docs" = {
          path = "/home/moritzzmn/sync/docs";
          devices = [ ];
        };
      };
    };
  };
}
