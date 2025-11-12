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
    "libomp"
  ];

  homebrew.casks = [
    "obsidian"
    "signal"
    "1password"
    "rider"
    "phpstorm"
    "floorp"
    "zen"
    "vscodium"
    "local"
    "lulu"
    "obs"
    "anydesk"
    "betterdisplay"
    "moonlight"
    "wezterm"
    "syncthing"
  ];
}
