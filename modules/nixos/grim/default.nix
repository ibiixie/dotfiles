{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.grim.enable = lib.mkEnableOption "enable the grim screenshot tool";
  };

  config = lib.mkIf config.modules.grim.enable {
    environment.systemPackages = with pkgs; [
      grim
    ];
  };
}
