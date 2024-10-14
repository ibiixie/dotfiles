{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.tlp.enable = lib.mkEnableOption "enable the tlp power-management tool";
  };

  config = lib.mkIf config.modules.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
