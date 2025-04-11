{
  description = "A Nix-flake-based Terraform learning shell with localstack this only fit with my Intel-base MacBook";

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
      pkgs = import nixpkgs {
        system = "${system}";
        config.allowUnfree = true;
      };
    in
    {
      devShells.x86_64-darwin.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          localstack
          terraform
          terraform-lsp
          awscli2
        ];

        shellHook = ''
          echo "Hello, welcome to Terraform learning dev shell"
        '';

        TERRAFORM_LSP = "${pkgs.terraform-lsp}/bin/";
      };
    };
}
