{
  pkgs,
  pkgs-unstable,
  ...
}:
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # C Sharp stuff
      roslyn-nvim
      rzls-nvim

      telescope-fzf-native-nvim
      telescope-nvim
      nvim-treesitter-textobjects
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          nix
          lua
          luadoc
          c_sharp
          razor
          typescript
          javascript
          tsx
          vue
          jsdoc
          git_config
          gitignore
          html
          python
          htmldjango
          jq
          just
          markdown
          markdown_inline
          php
          sql
          toml
          yaml
        ]
      ))
    ];
    extraPackages = with pkgs; [
      # needed to compile fzf-native for telescope-fzf-native.nvim
      gcc
      gnumake
      tree-sitter

      # language servers
      pkgs-unstable.nixd
      lua-language-server
      pkgs-unstable.just-lsp

      # default formatter & linter
      pkgs-unstable.nixfmt
      stylua
    ];
  };
}
