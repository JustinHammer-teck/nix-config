{
  description = "A Nix-flake-based Umbraco development environment";

   outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells."${system}".default = with pkgs; mkShell {
        name = "dotnet core dev shell";
        packages = [
          dotnetCorePackages.sdk_9_0
        ];

        nativeBuildInputs = with pkgs; [
          omnisharp-roslyn
          msbuild
        ];

        shellHook = ''
          echo "hello to csharp dev shell"  
          ${pkgs.dotnetCorePackages.sdk_9_0}/bin/dotnet --version
        '';

        DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_9_0}/bin/dotnet";
        OMNISHARP_PATH = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
      };
    };
}
