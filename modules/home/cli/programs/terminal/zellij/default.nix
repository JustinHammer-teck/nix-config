{ pkgs, lib, config, ... }:
with lib;
let cfg = config.programs.terminal.zellij;
in {
  options.programs.terminal.zellij = { enable = mkEnableOption "Zellij"; };
  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.zellij;
    };
  };
}
