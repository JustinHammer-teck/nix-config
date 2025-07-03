{
  config,
  ...
}:
{
  homebrew.enable = true;
  homebrew.global.brewfile = true;
  homebrew.global.lockfiles = true;

  homebrew.onActivation = {
    autoUpdate = true;
    cleanup = "zap";
    upgrade = true;
  };

  homebrew.taps = (builtins.attrNames config.nix-homebrew.taps);

  homebrew.brews = [
    "trash"
    "borders"
    "lima"
  ];

  homebrew.casks = [
    "obsidian"
    "signal"
    "1password"
    "rider"
    "pycharm"
    "phpstorm"
    "ghostty"
    "obs"
    "floorp"
    "mullvad-browser"
    "tor-browser"
    "zen"
    "vscodium"
    "insomnia"
    "lulu"
  ];
}
