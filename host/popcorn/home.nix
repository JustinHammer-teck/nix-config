{
  config,
  pkgs,
  pkgs-unstable,
  popcorn,
  lib,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  imports = [
    (import ../../modules/home/neovim/default.nix)
    (import ../../modules/home/git/default.nix)
  ];
  home = {
    stateVersion = "25.05";
    username = "${toString popcorn.user}";
    homeDirectory = "${toString popcorn.home-dir}";
    packages = with pkgs; [
      starship
      bat
      delta
      just

      pkgs-unstable.claude-code
    ];

    sessionVariables = {
      EDITOR = "${toString popcorn.editor}";
      HOME_MANAGER = "${pkgs.lib.makeLibraryPath [ pkgs.home-manager ]}";
    };

    file = {
      ".ideavimrc".text = builtins.readFile "${popcorn.dotfile-path}/.ideavimrc";
      ".config/nvim" = {
        source = mkOutOfStoreSymlink "${popcorn.dotfile-path}/nvim";
        recursive = true;
      };
      ".config/starship" = {
        source = mkOutOfStoreSymlink "${popcorn.dotfile-path}/starship";
        recursive = true;
      };
    };

  };

  git.enable = true;
  programs.git = {
    signing = lib.mkForce {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKfuyuHdyTNrtlNAcd3ychG6mVQOAUZu15za7KNMQWD dinhnhattai.nguyen@hotmail.com";
    };
  };

  wayland.windowManager.hyprland.settings.input.kb_options = lib.mkForce "caps:swapescape";

  programs.bash = {
    enable = true;
  };
}
