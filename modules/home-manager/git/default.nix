{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.git.enable = lib.mkEnableOption "enables and configures git through home-manager";
    modules.git.userName = lib.mkOption {
      description = "git username";
    };
    modules.git.userEmail = lib.mkOption {
      description = "git email";
    };
  };

  config = lib.mkIf config.modules.git.enable {
    programs.git = {
      enable = true;
      userName = config.modules.git.userName;
      userEmail = config.modules.git.userEmail;
    };
  };
}
