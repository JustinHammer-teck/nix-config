{
  description = "A Nix-flake-based Umbraco development environment";

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
      dotnet_pkg = pkgs.dotnetCorePackages.sdk_8_0;
    in
    {
      devShells."${system}".default =
        with pkgs;
        mkShell {
          name = "dotnet core dev shell";
          packages = [
            dotnet_pkg
          ];

          nativeBuildInputs = with pkgs; [
          ];

          shellHook = ''
            echo "hello to csharp dev shell"  
            ${dotnet_pkg}/bin/dotnet --version
          '';

          DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_8_0}/bin/dotnet";
        };
    };
}
