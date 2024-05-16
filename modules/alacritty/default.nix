{ pkgs, config, ... }:

{
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    colors = with config.colorScheme.colors; {
      bright = {
        black = "0x${base00}";
        blue = "0x${base0D}";
        cyan = "0x${base0C}";
        green = "0x${base0B}";
        magenta = "0x${base0E}";
        red = "0x${base08}";
        white = "0x${base06}";
        yellow = "0x${base09}";
      };
      cursor = {
        cursor = "0x${base06}";
        text = "0x${base06}";
      };
      normal = {
        black = "0x${base00}";
        blue = "0x${base0D}";
        cyan = "0x${base0C}";
        green = "0x${base0B}";
        magenta = "0x${base0E}";
        red = "0x${base08}";
        white = "0x${base06}";
        yellow = "0x${base0A}";
      };
      primary = {
        background = "0x${base00}";
        foreground = "0x${base06}";
      };
    };
    draw_bold_text_with_bright_colors = false;
    font = {
      bold = {
        family = "DroidSansM Nerd Font";
        style = "Bold";
      };
      bold_italic = {
        family = "DroidSansM Nerd Font";
        style = "Bold Italic";
      };
      italic = {
        family = "DroidSansM Nerd Font";
        style = "Italic";
      };
      normal = {
        family = "DroidSansM Nerd Font";
        style = "Regular";
      };
      size = 14;
    };
    window = { opacity = 0.95; };
  };
}
