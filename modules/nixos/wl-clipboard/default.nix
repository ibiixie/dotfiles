{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.wl-clipboard.enable = lib.mkEnableOption "enable the wl-clipboard tool";
  };

  config = lib.mkIf config.modules.wl-clipboard.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
    ];
  };
}
