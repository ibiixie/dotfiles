{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.hyprland.enable = lib.mkEnableOption "enables and configures hyprland through home-manager - note: you should enable the global module for hyprland too!";
    modules.hyprland.input.sensitivity = lib.mkOption {
      default = -0.75;
      type = lib.types.float;
      description = "sets the mouse/touchpad sensitivity";
    };
    modules.hyprland.input.keyboard.layout = lib.mkOption {
      default = "se";
      type = lib.types.string;
      description = "allows for overriding the keyboard layout";
    };
    modules.hyprland.input.acceleration = lib.mkOption {
      default = false;
      type = lib.types.bool;
      description = "wether to enable acceleration (libinput/synaptics profile) or not (flat profile)";
    };
    modules.hyprland.monitors = lib.mkOption {
      default = [ "auto, preferred, auto, 1" ];
      type = lib.types.listOf lib.types.string;
      description = "allows for overriding monitor configuration";
    };
  };

  config = lib.mkIf config.modules.hyprland.enable {
    # Theming stuff, not sure if it should be a separate module?
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.numix-cursor-theme;
      name = "Numix-Cursor";
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.gnome.gnome-themes-extra;
	name = "Adwaita-dark";
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = pkgs.hyprland;

      xwayland.enable = true;
      systemd.enable = true;

      # Fixes systemd not importing environment variables by default
      systemd.variables = [ "--all" ];

      settings = {
        "$mod" = "SUPER";

        "$terminal" = "foot";

        # monitor = [
        #   "eDP-1, preferred, auto, 1"
	# ];

	monitor = config.modules.hyprland.monitors;

        general = {
          gaps_in = 7;
          gaps_out = 14;

          border_size = 2;

          "col.active_border" = "rgba(ff7dd6ee) rgba(ff69b4ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          resize_on_border = true;

          allow_tearing = false;

          layout = "dwindle";
        };

        decoration = {
          rounding = 6;

          active_opacity = 1; # 0.8
          inactive_opacity = 1; # 0.8

          drop_shadow = false;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = "rgba(1a1a1aee)";

          blur = {
            enabled = false; # true
            size = 7;
            passes = 4;

            vibrancy = 0.24; # 0.1696
          };
        };

        animations = {
          enabled = false; # true

          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
            "specialWorkspace, 1, 6, default, slidefadevert 100%"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        input = {
          kb_layout = config.modules.hyprland.input.keyboard.layout; # se
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = 1;

          sensitivity = config.modules.hyprland.input.sensitivity; # -0.75
          accel_profile = lib.optionalAttrs (!config.modules.hyprland.input.acceleration) "flat";

          touchpad = {
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = true;
        };

        env = [
          "XCURSOR_SIZE,24"
          "HYPRCURSOR_SIZE,24"
        ];

        exec-once = [
          "swww-daemon" # should only be added if an swww option is enabled
          "gammastep -l 59:16" # should only be added if a gammastep option is enabled, and the coords should be an option too
          "otd-daemon" # should only be added if opentabletdriver option is enabled
          "ags -c ~/.config/ags/config.js" # should only be added if ags option is enabled
          ""
        ];

        binde = [
          ", XF86MonBrightnessUp, exec, echo 'Hello, world!' >> ~/test.txt"
        ];

        bind = [
          "$mod, Q, exec, $terminal"
          "$mod, C, killactive"
          "$mod, M, exit,"

          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy" # should only be added if screenshot option enabled (should it install them all if so too?)

          "$mod, Space, exec, ags -t applauncher" # should only be added if option "ags.applauncher.enable" is true (or maybe we can specify the applauncher exec args in a variable/option and feed it into here? or maybe extraConfig in home.nix? idk.

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          "$mod SHIFT, 1, movetoworkspace, 1"
          "$mod SHIFT, 2, movetoworkspace, 2"
          "$mod SHIFT, 3, movetoworkspace, 3"
          "$mod SHIFT, 4, movetoworkspace, 4"
          "$mod SHIFT, 5, movetoworkspace, 5"
          "$mod SHIFT, 6, movetoworkspace, 6"
          "$mod SHIFT, 7, movetoworkspace, 7"
          "$mod SHIFT, 8, movetoworkspace, 8"
          "$mod SHIFT, 9, movetoworkspace, 9"
          "$mod SHIFT, 0, movetoworkspace, 10"

          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"

          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ];

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        windowrulev2 = [
          "suppressevent maximize, class:.*"
        ];
      };
    };
  };
}
