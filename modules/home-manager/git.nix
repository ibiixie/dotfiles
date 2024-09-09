{ config, lib, pkgs, ... }:

{
  options = {
    programs.git.enable = lib.mkEnableOption "enable git";
  };

  config =  lib.mkIf config.programs.git.enable {
    home.packages = [
      pkgs.git
    ];
  };
}
