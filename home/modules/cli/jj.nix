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
        name = config.programs.git.settings.user.name;
        email = config.programs.git.settings.user.email;
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
