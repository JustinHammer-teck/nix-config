{
  config,
  pkgs,
  pkgs-unstable,
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
        delta
        just

        pkgs-unstable.tree-sitter

        iperf
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
      };
     
    };

    programs.git.enable = true;
    programs.bash = {
      enable = true;
    };
  };
}
