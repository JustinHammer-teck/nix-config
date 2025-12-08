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

      # universalaccess.reduceMotion = true; # Reduce Motion

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

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.configurationRevision = self.rev or self.dirtyRev or null;

  security.pam.services.sudo_local.touchIdAuth = true;
}
