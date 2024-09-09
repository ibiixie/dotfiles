{ config, lib, pkgs, ... }:

{
  with lib;

  options = {
    git.enable = mkEnableOption "enables git";
  };

  config =  mkIf config.git.enable {
   programs.git = {
     enable = true;
   };
  };
}
