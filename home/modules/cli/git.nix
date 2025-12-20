{
  config,
  ...
}:

{
  sops.secrets = {
    "users/biixie/ssh-key" = { };
  };

  programs.git = {
    enable = true;

    lfs.enable = true;

    settings = {
      user.name = "biixie";
      user.email = "no" + "-re" + "ply" + "@" + "bii" + "xie" + "." + "c" + "om";

      signing.signByDefault = true;
      signing.key = config.sops.secrets."users/biixie/ssh-key".path;

      gpg.format = "ssh";
      init.defaultBranch = "main";

      core.whitespace = "error";
      core.preloadindex = true;

      status = {
        branch = true;
        showStash = true;
        showUntrackedFiles = "all";
      };

      interactive = {
        singlekey = true;
      };

      push = {
        autoSetupRemote = true;
        default = "current";
      };

      pull = {
        default = "current";
        rebase = true;
      };

      rebase = {
        autoStash = true;
        missingCommitsCheck = "warn";
      };

      log = {
        abbrevCommit = true;
        graphColors = "blue,yellow,cyan,magenta,green,red";
      };
    };
  };
}
