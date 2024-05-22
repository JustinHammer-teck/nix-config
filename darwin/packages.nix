{ pkgs, pkgs-unstable, config, lib, vars, ... }: {
  imports = [ ./modules/yabai ./../modules/home/cli/programs/podman ];
  config = {
    environment = {
      shells = with pkgs; [ zsh ];
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      systemPackages = with pkgs; [
        neovim
        bat
        git
        ripgrep
        jq
        starship
        nil
        eza
        delta
        nixfmt
        zoxide
        tailscale
      ];
      # environment variables
      variables = {
        NIL_PATH = "${pkgs.nil}/bin/nil";
        EDITOR = "wezterm";
        VISUAL = "nvim";
      };
    };
    programs = { cli = { podman.enable = true; }; };
    services = {
      nix-daemon.enable = true;
      tailscale.enable = true;
      desktops.yabai.enable = true;
    };
  };
}
