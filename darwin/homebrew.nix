{ config, inputs, vars, ... }: {
  imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];

  nix-homebrew = {
    enable = true;
    user = "${vars.user}";
    taps = {
      "FelixKratz/homebrew-formulae" = inputs.felixkratz-formulae;
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
    mutableTaps = false;
    autoMigrate = true;
  };

  homebrew = {
    enable = true;
    global = {
      brewfile = true;
      lockfiles = true;
    };
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    taps = (builtins.attrNames config.nix-homebrew.taps);
    brews = [ "trash" "borders" "libomp" ];
    casks = [
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
      "syncthing-app"
    ];
  };

}
