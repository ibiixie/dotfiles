{ config, lib, pkgs, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;

    age.keyFile = "/home/${config.home.username}/.config/sops/age/keys.txt";

    secrets = {
      "ssh/personal.pub" = { };
      "ssh/personal" = { };
    };
  };
}
