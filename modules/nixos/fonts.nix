{
  config,
  libs,
  pkgs,
  ...
}:
{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      # Nerd Fonts (choose your favorites)
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.droid-sans-mono

      # Chinese fonts (REQUIRED for Chinese characters)
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
    ];

    fontconfig = {
      defaultFonts = {
        # Nerd Font first, then Chinese font as fallback
        monospace = [
          "Droid Sans Mono Nerd Font"
          "Noto Sans Mono CJK SC" # SC = Simplified Chinese
        ];
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif"
          "Noto Serif CJK SC"
        ];
      };
    };
  };
}
