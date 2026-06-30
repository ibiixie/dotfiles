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

      "hosts/twinkcentre/wireguard/vpn/private-key" = { };
      "hosts/twinkcentre/wireguard/vpn/peers/biixie/private-key" = { };
      "hosts/twinkcentre/wireguard/vpn/peers/biixie/preshared-key" = { };
      "hosts/twinkcentre/wireguard/vpn/peers/1cfa6c6e5fcfbd369733746c3552b9cb/private-key" = { };
      "hosts/twinkcentre/wireguard/vpn/peers/1cfa6c6e5fcfbd369733746c3552b9cb/preshared-key" = { };

      "hosts/twinkcentre/gh-runner-token" = { };
      "hosts/twinkcentre/codeberg-runner-token" = { };
    };
  };
}
