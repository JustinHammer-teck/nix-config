{
  description = "A Nix-flake-based Umbraco development environment";

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
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
            dotnet-ef
          ];

          nativeBuildInputs = with pkgs; [
          ];

          shellHook = ''
             ${dotnet_pkg}/bin/dotnet --version

             echo "remove last symlink"
             rm -rf ~/.dotnet/dotnet_sdk8

             mkdir -p ~/.dotnet/dotnet_sdk8/sdk/8.0.407

             echo "create symlink to .dotnet"
             ln -s ${dotnet_pkg}/share/dotnet/dotnet ~/.dotnet/dotnet_sdk8/dotnet
             ln -s ${dotnet_pkg}/share/dotnet/MSBuild.dll ~/.dotnet/dotnet_sdk8/sdk/8.0.407/MSBuild.dll

            echo "hello to csharp dev shell"  
          '';

          DOTNET_ROOT = "${dotnet_pkg}/bin/dotnet";
        };
    };
}
