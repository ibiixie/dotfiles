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
