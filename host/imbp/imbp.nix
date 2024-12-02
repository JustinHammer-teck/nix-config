{ self, config, vars, pkgs, ... }: {
  config = {
    nixpkgs.hostPlatform = "${vars.platform}";

    # User configuration
    users.users.${vars.user} = {
      name = "${vars.user}";
      home = "${vars.home-dir}";
    };

    networking.hostName = "${vars.host}";
    networking.localHostName = "${vars.host}";

    system.defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
      dock.minimize-to-application = true;

      spaces.spans-displays = false;
      screencapture.location = "~/Pictures/screenshots";

      finder.AppleShowAllExtensions = true;
      finder.FXEnableExtensionChangeWarning = false;
      finder.CreateDesktop = false;
      finder.FXPreferredViewStyle = "clmv"; # list view
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
      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      NSGlobalDomain.AppleICUForce24HourTime = true;
      NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
      NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
      NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
      NSGlobalDomain."com.apple.trackpad.scaling" = 3.0;
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    };

    system.configurationRevision = self.rev or self.dirtyRev or null;
    system.stateVersion = 5;
    security.pam.enableSudoTouchIdAuth = true;

    nix = {
      configureBuildUsers = true;
      useDaemon = true;
      optimise.automatic = true;
      settings = {
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
    system.activationScripts.applications.text = let
      env = pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
      };
    in
      pkgs.lib.mkForce ''
      # Set up applications.
      echo "setting up /Applications..." >&2
      rm -rf /Applications/Nix\ Apps
      mkdir -p /Applications/Nix\ Apps
      find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
      while read -r src; do
        app_name=$(basename "$src")
        echo "copying $src" >&2
        ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
      done
          '';
  };
}
