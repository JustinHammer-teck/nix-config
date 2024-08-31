{ pkgs, pkgs-unstable, config, lib, vars, ... }: {
  imports = [ 
  #./modules/yabai 
  ./../modules/home/cli/programs/podman ];
  config = {
    environment = {
      loginShell = pkgs.zsh;
      shells = with pkgs; [ zsh ];
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      #

      systemPackages = with pkgs; [
        neovim
        nil
        eza
        delta
        nixfmt-classic
        zoxide
        just

        pkgs-unstable.jetbrains.rider
      ];

      # environment variables
      variables = {
        NIL_PATH = "${pkgs.nil}/bin/nil";
        EDITOR = "nvim";
        VISUAL = "wezterm";
        PATH =
          "${pkgs-unstable.jetbrains.rider}/Applications/Rider.app/Contents/MacOS:$PATH";
      };
    };
    programs = { cli = { podman.enable = true; }; };
    services = {
      nix-daemon.enable = true;
      # desktops.yabai.enable = true;
      skhd.enable = true;
    };

    services.tailscale = {
      enable = true;
      package = pkgs-unstable.tailscale;
    };
    # Create /etc/zshrc that loads the nix-darwin environment.
    #
    programs.zsh.enable = true; # default shell on catalina

  };
}
