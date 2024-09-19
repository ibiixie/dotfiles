{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config = lib.mkIf config.modules.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
