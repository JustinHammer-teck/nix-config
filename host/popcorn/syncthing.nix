{ vars, ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    user = "${vars.user}";
    dataDir = "${vars.home-dir}";
    extraFlags = [ "--no-default-folder" ];
    settings = {
      devices = {
        "imbp" = {
          id = "NTJOMYH-SPH7IDP-7RJJH25-M3W53LL-A33QXQX-L7KCHWP-DWXRP3R-EZU6QQG";
        };
      };
      folders = {
        "docs" = {
          path = "/home/moritzzmn/sync/docs";
          devices = [ "imbp" ];
        };
      };
    };
  };
}
