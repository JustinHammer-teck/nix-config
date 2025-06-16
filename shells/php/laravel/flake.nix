{
  description = "A Nix-flake-based Laravel development environment - this only fit with my Intel-base MacBook";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05"; # Nix Packages (Default)
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs {
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
            intelephense
          ]
          ++ (with php84Packages; [
            composer
            psalm
            phpstan
          ]);
        shellHook = ''
          echo "Hello, welcome to laravel dev shell"
        '';
      };
    };
}
