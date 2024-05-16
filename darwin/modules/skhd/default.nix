{ pkgs, config, lib, home-manager-unstable, home, ... }:

{
  options.services.skhd = {
    enable = lib.mkEnableOption "skhd configuration";
    components = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ ];
    };
  };

  config = {
    home.file.".config/skhd/skhdrc" = lib.mkIf config.services.skhd.enable {
      text = lib.strings.concatStrings (lib.strings.intersperse "\n"
        (map builtins.readFile (map (filename: ./configs/skhd + "/${filename}")
          config.services.skhd.components)));
      onChange = "${pkgs.killall}/bin/killall skhd";
    };
  };
}
