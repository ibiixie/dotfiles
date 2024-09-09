{ config, lib, pkgs, ... }:

{
  options = {
    modules.neovim.enable = lib.mkEnableOption "enable neovim";
    modules.neovim.defaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "set neovim to the default editor using  the EDITOR env var";
    };
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
