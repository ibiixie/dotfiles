{ config, lib, pkgs, ... }:

{
  options = {
    modules.git.enable = lib.mkEnableOption "enable git";
    modules.git.channel = lib.mkOption {
      type = types.enum [ "stable" "unstable" "upstream" ];
      description = "allows selecting the channel to install from";
      default = "stable";
    }
  };

  config =  lib.mkIf config.modules.git.enable {
    home.packages = [
      pkgs.${config.modules.git.channel}.git
    ];
  };
}
