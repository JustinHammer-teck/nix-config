{
  description = "A Nix-flake-based Dotnet development environment";

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells."${system}".default =
        with pkgs;
        mkShell {
          name = "dotnet core";
          packages = [
            dotnetCorePackages.sdk_9_0
          ];

          nativeBuildInputs = with pkgs; [
            csharp-ls
          ];

          shellHook = ''
            echo "hello to csharp dev shell"

            export PATH="$PATH:/Users/moritzzmn/.dotnet/tools"

            ${pkgs.dotnetCorePackages.sdk_9_0}/bin/dotnet --version
          '';

          DOTNET_ROOT = "${pkgs.dotnetCorePackages.sdk_9_0}/bin/dotnet";
          CSHARP_LS = "${pkgs.csharp-ls}/bin/";
          #OMNISHARP_PATH = "${pkgs.omnisharp-roslyn}/bin/OmniSharp";
        };
    };
}
