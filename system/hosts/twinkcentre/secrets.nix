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
      "hosts/twinkcentre/password" = {
        neededForUsers = true;
        sopsFile = ../../../secrets/hosts/twinkcentre.yaml;
      };

      "hosts/twinkcentre/dotfiles-deploy-key" = {
        sopsFile = ../../../secrets/hosts/twinkcentre.yaml;
        owner = "twinkcentre";
        mode = "0600";
      };

      "hosts/twinkcentre/pushover-credentials" = {
        sopsFile = ../../../secrets/hosts/twinkcentre.yaml;
      };

      "hosts/twinkcentre/gh-runner-token" = { };
      "hosts/twinkcentre/codeberg-runner-token" = { };
    };
  };
}
