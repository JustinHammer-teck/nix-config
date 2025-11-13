{
  self,
  config,
  vars,
  pkgs,
  ...
}:
{
  nixpkgs.hostPlatform = "${vars.platform}";
  system = {

    checks.verifyNixPath = false;
    primaryUser = "${vars.user}";
    stateVersion = 5;
    defaults = {
      dock.autohide = true;
      dock.mru-spaces = false;
      dock.expose-animation-duration = 0.1;
      dock.autohide-delay = 0.0;
      dock.autohide-time-modifier = 0.0;

      spaces.spans-displays = false;
      screencapture.location = "~/Pictures/screenshots";

      finder.FXEnableExtensionChangeWarning = false;
      finder.CreateDesktop = false;
      finder.FXPreferredViewStyle = "Nlsv"; # list view
      finder.FXDefaultSearchScope = "SCcf";
      finder.ShowStatusBar = true;
      finder.ShowPathbar = true;

      # Removing trash after 30 days
      finder.FXRemoveOldTrashItems = true;

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };

      universalaccess.reduceMotion = true; # Reduce Motion

      NSGlobalDomain.NSAutomaticWindowAnimationsEnabled = false;

      NSGlobalDomain.AppleInterfaceStyle = "Dark";
      NSGlobalDomain.AppleICUForce24HourTime = true;
      NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
      NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
      NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
      NSGlobalDomain."com.apple.trackpad.scaling" = 3.0;

      # Set Finder to show all extension
      NSGlobalDomain.AppleShowAllExtensions = true;

      # Sidebar Icon Size Small
      NSGlobalDomain.NSTableViewDefaultSizeMode = 1;

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
    };
  };

  system.configurationRevision = self.rev or self.dirtyRev or null;

  security.pam.services.sudo_local.touchIdAuth = true;

  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.dates = "weekly";
  #
  system.activationScripts.applications.text =
    let
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
}
