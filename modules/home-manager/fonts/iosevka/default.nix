{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.fonts.iosevka.enable = lib.mkEnableOption "enable the iosevka font";
  };

  config = lib.mkIf config.modules.fonts.iosevka.enable {
    home.packages = with pkgs; [
      iosevka
    ];
  };
}
