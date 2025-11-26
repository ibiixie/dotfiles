{
  config,
  ...
}:

{
  programs.ssh = {
    enable = true;

    enableDefaultConfig = false;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = config.sops.secrets."users/biixie/ssh-key".path;
      };

      "twinkpad" = {
        hostname = "192.168.1.34";
        user = "biixie";
        port = 21622;
        identityFile = config.sops.secrets."users/biixie/ssh-key".path;
      };

      "twinkcentre" = {
        hostname = "192.168.1.76";
        user = "biixie";
        port = 21622;
        identityFile = config.sops.secrets."users/biixie/ssh-key".path;
      };

      "oci-main" = {
        hostname = "main.ssh.biixie.com";
        user = "opc";
        identityFile = config.sops.secrets."services/vpses/oci-main/ssh-key".path;
      };

      "oci-aux" = {
        hostname = "aux.ssh.biixie.com";
        user = "ubuntu";
        identityFile = config.sops.secrets."services/vpses/oci-aux/ssh-key".path;
      };

      "gcp" = {
        hostname = "gcp.ssh.biixie.com";
        user = "biixiebot";
        identityFile = config.sops.secrets."services/vpses/gcp/ssh-key".path;
      };
    };
  };
}
