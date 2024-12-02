{ config, lib, pkgs, ... }:

with lib;
let cfg = config.programs.cli.terminal.starship;
in {
  options.programs.cli.terminal.starship = {
    enable = mkEnableOption "StarShip Prompt ";
  };
  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      package = pkgs.starship;
      enableZshIntegration = true;
      settings = pkgs.lib.importTOML ~/DotFile/starship/starship.toml;
    };
  };
}

