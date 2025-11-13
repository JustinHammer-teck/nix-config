{ config, lib, pkgs, vars, ... }:

with lib;
let cfg = config.programs.cli.terminal.starship;
in {
  options.terminal.starship = { enable = mkEnableOption "StarShip Prompt "; };
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      package = pkgs.starship;
      enableZshIntegration = true;
    };
  };
}

