{
  config,
  inputs,
  ...
}:

{
  sops = {
    defaultSopsFile = ../../../secrets/hosts/twinkpad.yaml;

    age.keyFile = "/etc/sops/age/keys.txt";

    secrets = {
      "users/biixie/password" = {
        neededForUsers = true;
        sopsFile = ../../../secrets/users/biixie.yaml;
      };
    };
  };
}
