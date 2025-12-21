{
  pkgs,
  lib,
  ...
}:
{
  # * Check implementation here:  https://github.com/henrysipp/omarchy-nix
  omarchy = {
    full_name = "Moritz Zimmerman";
    email_address = "dinhnhattai.nguyen@hotmail.com";
    theme = "everforest";
    exclude_packages = with pkgs; [
      typora
    ];
    quick_app_bindings = [
      "SUPER, slash, exec, $passwordManager --ozone-platform=wayland --enable-features=UseOzonePlatform"

      "SUPER, B, exec, $browser"
      "SUPER, C, exec, $webapp=https://claude.com"

      "SUPER, D, exec, $terminal -e lazydocker"

      "SUPER, T, exec, $terminal"
      "SUPER, F, exec, $fileManager"
      "SUPER, N, exec, $terminal -e nvim"
      "SUPER, M, exec, $terminal -e btop"
      "SUPER, S, exec, $messenger"
    ];
  };
}
