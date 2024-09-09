{ config, lib, pkgs, ... }:

{
  options = {
    git.enable = mkEnableOption "enables git";
  };

  config =  mkIf config.git.enable {
   programs.git = {
      enable = true;
    };
  };
}
