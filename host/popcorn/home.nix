{
  config,
  pkgs,
  popcorn,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  config = {
    home = {
      stateVersion = "25.05";
      username = "${toString popcorn.user}";
      homeDirectory = "${toString popcorn.home-dir}";
      packages = with pkgs; [
        starship
        bat
        lazygit
        delta
        just
        fzf
        ripgrep

        iperf
      ];

      sessionVariables = {
        EDITOR = "${toString popcorn.editor}";
        HOME_MANAGER = "${pkgs.lib.makeLibraryPath [ pkgs.home-manager ]}";
      };
    };

    programs.git.enable = true;
    programs.bash = {
      enable = true;
    };
  };
}
