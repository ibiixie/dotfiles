{
  config,
  inputs,
  ...
}:

{
  sops = {
    defaultSopsFile = ../../../secrets/hosts/twinkcentre.yaml;

    age.keyFile = "/etc/sops/age/keys.txt";

    secrets = {
      "users/biixie/password" = {
        neededForUsers = true;
        sopsFile = ../../../secrets/users/biixie.yaml;
      };

      "hosts/twinkcentre/gh-runner-token" = { };
      "hosts/twinkcentre/codeberg-runner-token" = { };
    };
  };
}
