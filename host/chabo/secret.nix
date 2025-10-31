{
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./../../secret.yaml;
    validateSopsFiles = false;

    age = {
      keyFile = (builtins.readFile "/Users/moritzzmn/.config/sops/age/keys.txt");
    };
  };
}
