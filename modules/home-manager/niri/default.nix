{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.niri.enable = lib.mkEnableOption "enable the niri wm";
  };

  config = lib.mkIf config.modules.niri.enable {
    programs.niri = {
      enable = true;

      settings = {

        environment = {
          NIXOS_OZONE_WL = "1";
				};

        input = {
          keyboard = {
            xkb = {
              layout = "se";
	    			};
	  			};
					touchpad = {
						tap = true;
						natural-scroll = true;
						accel-profile = "adaptive";
						accel-speed = -0.25;
					};
				};

				binds = with config.lib.niri.actions; {
				  "XF86AudioRaiseVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+";
				  "XF86AudioLowerVolume".action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";
					"XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
					"XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

					"XF86MonBrightnessUp".action = spawn "blctl" "increase" "5";
					"XF86MonBrightnessDown".action = spawn "blctl" "decrease" "5";

				  "Mod+D".action = spawn "fuzzel";

				  "Mod+1".action = focus-workspace 1;
				  "Mod+2".action = focus-workspace 2;
				  "Mod+3".action = focus-workspace 3;
				  "Mod+4".action = focus-workspace 4;
				  "Mod+5".action = focus-workspace 5;
				  "Mod+6".action = focus-workspace 6;
				  "Mod+7".action = focus-workspace 7;
				  "Mod+8".action = focus-workspace 8;
				  "Mod+9".action = focus-workspace 9;
				  "Mod+0".action = focus-workspace 10;

				  "Mod+Shift+Q".action = quit;

				  "Mod+Plus".action = set-column-width "+5%";
				  "Mod+Minus".action = set-column-width "-5%";

				  "Print".action = screenshot;

					"Mod+F".action = maximize-column;
				  "Mod+Shift+F".action = fullscreen-window;

				  "Mod+Q".action = close-window;

				  "Mod+H".action = focus-column-left;
				  "Mod+L".action = focus-column-right;
				  "Mod+K".action = focus-window-up;
				  "Mod+J".action = focus-window-down;

					"Mod+C".action = center-column;

				  "Mod+Shift+H".action = move-column-left;
				  "Mod+Shift+L".action = move-column-right;
				  "Mod+Shift+K".action = move-window-up;
				  "Mod+Shift+J".action = move-window-down;

					"Mod+Tab".action = switch-preset-column-width;
					"Mod+Shift+Tab".action = focus-workspace-previous;

					"Mod+Alt+H".action = show-hotkey-overlay;
				};

				layout = {
					center-focused-column = "never";
					default-column-width = { proportion = 1. / 2.; };
					preset-column-widths = [
						{ proportion = 1. / 3.; }
						{ proportion = 1. / 2.; }
						{ proportion = 2. / 3.; }
						{ proportion = 4. / 5.; }
						{ proportion = 4. / 4.; }
					];
				};
      };
    };
  };
}
