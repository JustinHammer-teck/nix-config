{ config, pkgs, lib, vars, ... }: {

  config = {
    # User configuration
    users.users.${vars.user} = {
      name = "${vars.user}";
      home = "${vars.home-dir}";
    };

    system.defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
      dock.minimize-to-application = true;
      dock.show-recents = false;

      spaces.spans-displays = false;
      screencapture.location = "/tmp";

      finder.AppleShowAllExtensions = true;
      finder.FXEnableExtensionChangeWarning = false;
      finder.CreateDesktop = false;
      finder.FXPreferredViewStyle = "Nlsv"; # list view
      finder.ShowPathbar = true;

      loginwindow.GuestEnabled = false;

      CustomUserPreferences = {
        # 3 finger dragging
        "com.apple.AppleMultitouchTrackpad".DragLock = false;
        "com.apple.AppleMultitouchTrackpad".Dragging = false;
        "com.apple.AppleMultitouchTrackpad".TrackpadThreeFingerDrag = true;

        # Finder's default location upon open
        "com.apple.finder".NewWindowTargetPath =
          "file://${config.users.users.moritzzmn.home}/";
      };

      NSGlobalDomain.AppleICUForce24HourTime = true;
      NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = true;
      NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
      NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
      NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
      NSGlobalDomain."com.apple.trackpad.scaling" = 3.0;
    };

    system.keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };

    # Create /etc/zshrc that loads the nix-darwin environment.
    #
    programs.zsh.enable = true; # default shell on catalina

    # programs.fish.enable = true;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    # system.stateVersion = 4;

    security.pam.enableSudoTouchIdAuth = true;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "x86_64-darwin";

    # Optimize Nix storage 
    nix = {
      settings = {
        auto-optimise-store = true;
        # Necessary for using flakes on this system.
        experimental-features = "nix-command flakes";
      };
      gc = {
        automatic = true;
        interval.Day = 7;
        options = "--delete-older-than 7d";
      };
      extraOptions = ''
        auto-optimise-store = true
      '';
    };
  };
}
