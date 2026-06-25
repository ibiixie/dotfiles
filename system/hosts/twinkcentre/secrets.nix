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
      "users/twinkcentre/password" = {
        neededForUsers = true;
        sopsFile = ../../../secrets/users/twinkcentre.yaml;
      };

      "users/twinkcentre/dotfiles-deploy-key" = {
        sopsFile = ../../../secrets/users/twinkcentre.yaml;
      };

      "hosts/twinkcentre/gh-runner-token" = { };
      "hosts/twinkcentre/codeberg-runner-token" = { };
    };
  };
}
