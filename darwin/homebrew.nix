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
    upgrade = true;
    cleanup = "zap";
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
    "floorp"
    "tor-browser"
    "zen"
    "vscodium"
    "lulu"
    "obs"
  ];
}
