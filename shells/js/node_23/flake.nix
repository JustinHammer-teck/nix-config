{
  description = "A Nix-flake-based python development environment - this only fit with my Intel-base MacBook";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11"; # Nix Packages (Default)
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.x86_64-darwin.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          nodejs_latest
          vtsls
          pnpm_10
          prettierd
        ];

        shellHook = ''
          echo "Hello, welcome to Three.js dev shell"
        '';

        VTSLS_PATH = "${pkgs.vtsls}/bin/vtsls";
      };
    };
}
