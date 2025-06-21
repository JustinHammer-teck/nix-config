{ pkgs, ... }:
{
  system.primaryUser = "moritzzmn";
  homebrew.enable = true;
  homebrew.global.brewfile = true;
  homebrew.global.lockfiles = true;

  homebrew.onActivation = {
    autoUpdate = true;
    upgrade = true;
  };

  # homebrew.taps = [
  #   "FelixKratz/formulae"
  # ];

  homebrew.brews = [
    "trash"
    "borders"
    "lima"
  ];

  homebrew.casks = [
    "obsidian"
    "floorp"
    "signal"
    "1password"
    "rider"
    "tor-browser"
    "hammerspoon"
    "ghostty"
    "obs"
    "mullvad-browser"
    "vscodium"
    "insomnia"
    "lulu"
  ];
}
