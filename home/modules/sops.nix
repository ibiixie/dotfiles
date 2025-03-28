{
  inputs,
  config,
  ...
}:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;

    age.keyFile = "/home/${config.home.username}/.config/sops/age/keys.txt";

    secrets = {
      "ssh/personal.pub" = { };
      "ssh/personal" = { };

      "ssh/oracle-vps.pub" = { };
      "ssh/oracle-vps" = { };

      "ssh/gcp-vps-user" = { };
    };
  };
}
