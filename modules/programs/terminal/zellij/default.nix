{ pkgs, lib, config, ... }:

let cfg = config.programs.termnial.zellij;
in {
  options.programs.terminal.zellij = { enable = lib.mkEnableOption "Zellij"; };
  config = lib.mkIf cfg.enable {
    programs.zellij = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.zellij;
    };
  };
}
