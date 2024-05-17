{
  config,
  lib,
  ...
}:
with lib;
with lib.moritzzmn; let
  cfg = config.terminals.alacritty;
in {
  options.terminals.alacritty = with types; {
    enable = mkBoolOpt false "enable alacritty terminal emulator";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      catppuccin.enable = true;

      settings = {
        shell = {
          program = "fish";
        };

        window = {
          padding = {
            x = 30;
            y = 30;
          };
          decorations = "none";
        };

        selection = {
          save_to_clipboard = true;
        };

        mouse_bindings = [
          {
            mouse = "Right";
            action = "Paste";
          }
        ];

        env = {
          TERM = "xterm-256color";
        };

        font = {
          normal = {
            monospace = "DroidSansM Nerd Font";
            style = "Regular";
          };
          bold = {
            monospace = "DroidSansM Nerd Font";
            style = "Bold";
          };
          italic = {
            monospace = "DroidSansM Nerd Font";
            style = "Italic";
          };
          size = 14.0;
        };
      };
    };
  };
}
