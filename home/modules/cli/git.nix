{
  config,
  ...
}:

{
  programs.git = {
    enable = true;

    lfs.enable = true;

    userEmail = "65206220+ibiixie@users.noreply.github.com";
    userName = "biixie";

    signing.signByDefault = true;
    signing.key = "${config.sops.secrets."ssh/personal".path}";

    extraConfig = {
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
