{ pkgs, ... }: {

  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    prefix = "C-s";
  };
}

