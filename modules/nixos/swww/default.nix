{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.swww.enable = lib.mkEnableOption "enable swww";
  };

  config = lib.mkIf config.modules.swww.enable {
    environment.systemPackages = with pkgs; [
      swww
    ];
  };
}
