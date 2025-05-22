{
  description = "A Nix-flake-based python development environment - this only fit with my Intel-base MacBook";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; # Nix Packages (Default)
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      venvDir = "venv";
    in
    {
      devShells.x86_64-darwin.default = pkgs.mkShell {
        nativeBuildInputs =
          with pkgs;
          [
            python312
            virtualenv
            nodejs_latest
            uv
          ]
          ++ (with pkgs.python312Packages; [
            pip
          ]);

        shellHook = ''
          echo "Hello, welcome to python dev shell"
        '';

        PYTHON_PATH = "${pkgs.python312}/bin/python3";
      };
    };
}
