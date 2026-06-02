{
  config,
  ...
}:

{
  imports = [
    ./secrets.nix
  ];

  home.username = "twinkcentre";
  home.homeDirectory = "/home/biixie";

  home.stateVersion = "24.11";

  systemd.user.startServices = "sd-switch";

  # sops.secrets = { };

  programs = {
    home-manager.enable = true;
    btop.enable = true;

    ssh = {
      enable = true;

      enableDefaultConfig = false;

      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = config.sops.secrets."users/twinkcentre/dotfiles-deploy-key".path;
        };

        "codeberg.org" = {
          hostname = "codeberg.org";
          user = "git";
          identityFile = config.sops.secrets."users/twinkcentre/dotfiles-deploy-key".path;
        };
      };
    };

    git = {
      enable = true;

      lfs.enable = true;

      settings = {
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
  };
}
