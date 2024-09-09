{ config, lib, pkgs, ... }:

{
  options = {
    modules.hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config =  lib.mkIf config.modules.hyprland.enable {
    programs.hyprland = {
      enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";

        binde = [
          ", XF86MonBrightnessUp, exec, echo 'Hello, world!' >> ~/test.txt"
        ];
      };
    };
  };
}
