{ config, lib, pkgs, ... }:

{
  options = {
    modules.git.enable = lib.mkEnableOption "enable git";
  };

  config =  lib.mkIf config.modules.git.enable {
    home.packages = [
      pkgs.upstream.git
    ];
  };
}
