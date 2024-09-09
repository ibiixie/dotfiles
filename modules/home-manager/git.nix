{ config, lib, pkgs, ... }:

{
  options = {
    modules.git.enable = lib.mkEnableOption "enable git";
    modules.git.userName = lib.mkOption {
      description = "git username";
    };
    modules.git.userEmail = lib.mkOption {
      description = "git email";
    };
    # modules.git.channel = lib.mkOption {
    #   type = lib.types.enum [ "stable" "unstable" "upstream" ];
    #   description = "specifies the channel to install from: (stable [default], unstable, upstream)";
    #   default = "stable";
    # };
  };

  config =  lib.mkIf config.modules.git.enable {
    # home.packages = [
    #   pkgs.${config.modules.git.channel}.git
    # ];

    programs.upstream.git = {
      enable = true;
      userName = config.modules.git.userName;
      userEmail = config.modules.git.userEmail;
    };
  };
}
