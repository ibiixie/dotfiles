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
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}
