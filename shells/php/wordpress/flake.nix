{
  description = "A Nix-flake-based Tailpress development environment - this only fit with my Intel-base MacBook";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; # Nix Packages (Default)
  };

  outputs =
    {
      ...
    }@inputs:
    let

      system = "x86_64-darwin";
      pkgs = import inputs.nixpkgs {
        system = "${system}";
        config.allowUnfree = true;
      };
    in
    {
      devShells.x86_64-darwin.default = pkgs.mkShell {
        nativeBuildInputs =
          with pkgs;
          [
            php84
            nodejs
            pnpm
            vtsls
            eslint_d
            prettierd
          ]
          ++ (with php84Packages; [
            composer
            psalm
            phpstan
          ]);
        shellHook = ''
          echo "Hello, welcome to Tailpress dev shell"
        '';

        PRETTIERD = "${pkgs.prettierd}/bin/prettierd";
        ESLINT = "${pkgs.eslint_d}/bin/eslint_d";
      };
    };
}
