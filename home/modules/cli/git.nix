{
  config,
  ...
}:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    userEmail = "65206220+ibiixie@users.noreply.github.com";
    userName = "ibiixie";

    signing.signByDefault = true;
    signing.key = "${config.sops.secrets."ssh/personal".path}";

    extraConfig = {
      gpg.format = "ssh";
    };
  };
}
