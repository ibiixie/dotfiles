{
  config,
  ...
}:

{
  sops.secrets = {
    "users/biixie/ssh-key" = { };
  };

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
        key = config.sops.secrets."users/biixie/ssh-key".path;
      };
      ui = {
        default-command = "log";

        # annoying pagination be gone >:c
        paginate = "never";
      };
    };
  };
}
