{ pkgs, lib, config, vars, ... }:
with lib;
let cfg = config.programs.terminal.zellij;
in {
  options.programs.terminal.zellij = { enable = mkEnableOption "Zellij"; };
  config = mkIf cfg.enable {
    xdg.configFile = {
      "zellij/config.kdl".source = (vars.home-dir + ".config/zellij/config.kdl");
      "zellij/layouts/mine.kdl".text = ''
        layout {
        	pane size=1 borderless=true {
        		plugin location="zellij:compact-bar"
        	}
        	pane
        }
      '';
    };
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.zellij;
      catppuccin.enable = true;
      catppuccin.flavor = "macchiato";
    };
  };
}
