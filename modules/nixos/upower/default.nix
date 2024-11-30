{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.upower.enable = lib.mkEnableOption "enable the upower tool";
  };

  config = lib.mkIf config.modules.upower.enable {
    services.upower.enable = true;
  };
}
