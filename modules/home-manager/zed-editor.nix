{ config, lib, pkgs, ... }:

{
  options = {
    modules.zed-editor.enable = lib.mkEnableOption "enable zed";
  };

  config =  lib.mkIf config.modules.git.enable {
    home.packages = [
      pkgs.unstable.zed-editor
    ];
  };
}
