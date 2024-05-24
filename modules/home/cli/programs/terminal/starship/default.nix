{ config, lib, pkgs, vars, ... }:

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
      catppuccin.enable = true;
      
    };
    #programs.starship.settings = builtins.readFile( vars.home-dir + ".config/starship.toml");
  };
}

