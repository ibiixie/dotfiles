{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.vesktop.enable = lib.mkEnableOption "enable the cutest discord client";
  };

  config = lib.mkIf config.modules.vesktop.enable {
    environment.systemPackages = with pkgs; [
      vesktop
    ];
  };
}
