{ ... }:
{
  # Enable Homebrew
  # Note that enabling this option does not install Homebrew, see the Homebrew website for installation instructions.
  # https://brew.sh/
  # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable
  homebrew.enable = true;
  # Automatically use the Brewfile that this module generates in the Nix store
  # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.global.brewfile
  homebrew.global.brewfile = true;
  homebrew.global.lockfiles = false;

  homebrew.onActivation = {
    cleanup = "zap";
    autoUpdate = false;
    upgrade = false;
  };

  homebrew.taps = [
    #  "homebrew/cask-fonts"
    #  "homebrew/cask-versions"
    #  "homebrew/services"
    "cfergeau/crc"
    "FelixKratz/formulae"
  ];

  # List of Homebrew formulae to install.
  # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.brews
  homebrew.brews = [
    "trash"
    "borders"
  ]; # vfkit is needed for podman 5.*.*

  # List of Homebrew casks to install.
  # https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.casks
  homebrew.casks = [
    "obsidian"
    "floorp"
    "signal"
    "1password"
    "lulu"
    "rider"
    "orbstack"
    "sioyek"
    "zen-browser"
    "wezterm"
    "tor-browser"
    "insomnia"
    "dangerzone"
    "ghostty"
  ];
}
