{ config, lib, pkgs, ... }:

{
  options = {
    modules.hyprland.enable = lib.mkEnableOption "enable hyprland";
  };

  config =  lib.mkIf config.modules.hyprland.enable {
    # The below is required in the nixos config but how do I ensure it is enabled?
    # programs.hyprland = {
    #   enable = true;
    # };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";

        "$terminal" = "foot";

        input = {
          kb_layout="se";
	};

        env = [
          "XCURSOR_SIZE,24"
	  "HYPRCURSOR_SIZE,24"
	];

        binde = [
          ", XF86MonBrightnessUp, exec, echo 'Hello, world!' >> ~/test.txt"
        ];

	bind = [
          "$mod, Q, exec, $terminal"
	  "$mod, C, killactive"
	  "$mod, M, exit,"
	];
      };
    };
  };
}
