# User secrets

{
  inputs,
  ...
}:

let
  ageKeyFilepath = "/etc/sops/age/keys.txt";
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  home.sessionVariables.SOPS_AGE_KEY_FILE = ageKeyFilepath;

  sops = {
    defaultSopsFile = ../../../secrets/users/twinkcentre.yaml;

    age = {
      keyFile = ageKeyFilepath;
    };

    # secrets = {
    #   "users/twinkcentre/ssh-key-pub" = {
    #     sopsFile = ../../../secrets/users/twinkcentre.yaml;
    #   };

    #   "users/biixie/ssh-key" = {
    #     sopsFile = ../../../secrets/users/biixie.yaml;
    #   };

    #   "services/vpses/oci-main/ssh-key-pub" = {
    #     sopsFile = ../../../secrets/services/vpses/oci-main.yaml;
    #   };

    #   "services/vpses/oci-main/ssh-key" = {
    #     sopsFile = ../../../secrets/services/vpses/oci-main.yaml;
    #   };

    #   "services/vpses/oci-aux/ssh-key-pub" = {
    #     sopsFile = ../../../secrets/services/vpses/oci-aux.yaml;
    #   };

    #   "services/vpses/oci-aux/ssh-key" = {
    #     sopsFile = ../../../secrets/services/vpses/oci-aux.yaml;
    #   };

    #   "services/vpses/gcp/ssh-key" = {
    #     sopsFile = ../../../secrets/services/vpses/gcp.yaml;
    #   };
    # };
  };
}
