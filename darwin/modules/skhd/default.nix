{ pkgs, config, lib, home-manager-unstable, home, ... }:

with lib;
let cfg = config.services.desktops.skhd;
in {
  options.services.desktops.skhd = {
    enable = mkEnableOption "skhd configuration";
    components = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    home.file.".config/skhd/skhdrc" = {
      text = lib.strings.concatStrings (lib.strings.intersperse "\n"
        (map builtins.readFile (map (filename: ./configs/skhd + "/${filename}")
          config.services.desktops.skhd.components)));
    };
  };
}
