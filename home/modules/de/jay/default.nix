{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./options.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard-rs
  ];

  services.swww = {
    enable = true;
  };

  wayland.windowManager.jay = {
    enable = true;

    settings = {
      gfx-api = "OpenGl";

      show-bar = false;

      theme =
        let
          colorScheme = with config.stylix.base16Scheme; {
            background = base00;
            accent = base0E;
            text = base05;
            hover = base02;
            green = base0B;
            yellow = base0A;
            red = base08;
          };
        in
        {
          # TODO: These should be 0 but it's not allowed in the current release.
          title-height = 1;
          border-width = 1;
          bar-height = 1;

          bg-color = "#0000";
          attention-requested-bg-color = "#0000";
          bar-bg-color = "#0000";
          # border-color = "#${colorScheme.accent}";
          border-color = "#0000";
        };

      outputs = [
        {
          name = "internal";
          match.serial-number = "0";
          x = 0;
          y = 0;
        }
        {
          name = "desktop-m27qa";
          match.serial-number = "FA3T01940000";
          x = 1920;
          y = 0;
          mode = {
            width = 2560;
            height = 1440;
            refresh-rate = 180;
          };
        }
      ];

      keymap = ''
        xkb_keymap {
          xkb_keycodes { include "evdev+aliases(qwerty)" };
          xkb_types    { include "complete"              };
          xkb_compat   { include "complete"              };
          xkb_symbols  { include "pc+se+inet(evdev)"     };
        };
      '';

      inputs = [
        {
          match.name = "SynPS/2 Synaptics TouchPad";
          tap-enabled = true;
          tap-drag-enabled = true;
          tap-drag-lock-enabled = true;
          natural-scrolling = true;
        }
      ];

      complex-shortcuts = {
        XF86MonBrightnessUp = {
          action = {
            type = "exec";
            exec = [
              "blctl"
              "increase"
              "10"
            ];
          };
        };

        XF86MonBrightnessDown = {
          action = {
            type = "exec";
            exec = [
              "blctl"
              "decrease"
              "10"
            ];
          };
        };

        XF86AudioRaiseVolume = {
          action = {
            type = "exec";
            exec = [
              "wpctl"
              "set-volume"
              "-l"
              "1.4"
              "@DEFAULT_AUDIO_SINK@"
              "5%+"
            ];
          };
        };

        XF86AudioLowerVolume = {
          action = {
            type = "exec";
            exec = [
              "wpctl"
              "set-volume"
              "-l"
              "1.4"
              "@DEFAULT_AUDIO_SINK@"
              "5%-"
            ];
          };
        };

        XF86AudioMute = {
          action = {
            type = "exec";
            exec = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
          };
        };

        XF86AudioMicMute = {
          action = {
            type = "exec";
            exec = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ];
          };
        };

        Print = {
          action = {
            type = "exec";
            exec = [
              "grim"
              "-g"
              "\"$(slurp)\""
              "-"
              "|"
              "wl-copy"
              "-t"
              "image/png"
            ];
          };
        };

      };

      shortcuts = {
        alt-t = {
          type = "exec";
          exec = "foot";
        };

        alt-space = {
          type = "exec";
          exec = "anyrun";
        };

        alt-q = "close";

        alt-F4 = "quit";

        alt-h = "focus-left";
        alt-j = "focus-down";
        alt-k = "focus-up";
        alt-l = "focus-right";

        alt-shift-h = "move-left";
        alt-shift-j = "move-down";
        alt-shift-k = "move-up";
        alt-shift-l = "move-right";

        alt-shift-1 = {
          type = "move-to-workspace";
          name = "1";
        };

        alt-shift-2 = {
          type = "move-to-workspace";
          name = "2";
        };

        alt-shift-3 = {
          type = "move-to-workspace";
          name = "3";
        };

        alt-shift-4 = {
          type = "move-to-workspace";
          name = "4";
        };

        alt-shift-5 = {
          type = "move-to-workspace";
          name = "5";
        };

        alt-shift-6 = {
          type = "move-to-workspace";
          name = "6";
        };

        alt-shift-7 = {
          type = "move-to-workspace";
          name = "7";
        };

        alt-shift-8 = {
          type = "move-to-workspace";
          name = "8";
        };

        alt-shift-9 = {
          type = "move-to-workspace";
          name = "9";
        };

        alt-shift-0 = {
          type = "move-to-workspace";
          name = "0";
        };
        alt-1 = {
          type = "show-workspace";
          name = "1";
        };

        alt-2 = {
          type = "show-workspace";
          name = "2";
        };

        alt-3 = {
          type = "show-workspace";
          name = "3";
        };

        alt-4 = {
          type = "show-workspace";
          name = "4";
        };

        alt-5 = {
          type = "show-workspace";
          name = "5";
        };

        alt-6 = {
          type = "show-workspace";
          name = "6";
        };

        alt-7 = {
          type = "show-workspace";
          name = "7";
        };

        alt-8 = {
          type = "show-workspace";
          name = "8";
        };

        alt-9 = {
          type = "show-workspace";
          name = "9";
        };

        alt-0 = {
          type = "show-workspace";
          name = "0";
        };
      };
    };
  };
}
