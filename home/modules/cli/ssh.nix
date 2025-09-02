{
  config,
  ...
}:

{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${config.sops.secrets."ssh/personal".path}";
      };

      "e495" = {
        hostname = "192.168.1.34";
        user = "biixie";
        port = 21622;
        identityFile = "${config.sops.secrets."ssh/personal".path}";
      };

      "oci-main" = {
        hostname = "main.ssh.biixie.com";
        user = "opc";
        identityFile = "${config.sops.secrets."ssh/oci-main".path}";
      };

      "oci-aux" = {
        hostname = "aux.ssh.biixie.com";
        user = "ubuntu";
        identityFile = "${config.sops.secrets."ssh/oracle-vps".path}";
      };

      "gcp-aux" = {
        hostname = "aux-gcp.ssh.biixie.com";
        user = "biixiebot";
        identityFile = "${config.sops.secrets."ssh/oracle-vps".path}";
      };
    };
  };
}
