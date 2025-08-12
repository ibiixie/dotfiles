{
  config,
  ...
}:

{
  programs.jujutsu = {
    enable = true;

    settings = {
      user = {
        email = "65206220+ibiixie@users.noreply.github.com";
        name = "biixie";
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "${config.sops.secrets."ssh/personal".path}";
      };
    };
  };
}
