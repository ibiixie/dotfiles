{
  osConfig,
  ...
}:

let
  superKey = "Control_L";
in

{
  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      general = {
        allow_tearing = true;
        resize_on_border = true;

        border_size = 2;
      };

      monitor = with osConfig.settings.display; [
        "${toString source}, ${toString resolution.width}x${toString resolution.height}@${toString refreshRate}, ${toString position.x}x${toString position.y}, ${toString scale}"
      ];

      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };

      decoration = {
        rounding = 10;
        # active_opacity = 0.8;
        # inactive_opacity = 0.75;
        # fullscreen_opacity = 1.0;

        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;

          size = 6;
          passes = 2;
          ignore_opacity = true;
          xray = false;
        };

        shadow = {
          enabled = true;

          range = 30;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, default"
          "workspaces, 1, 5, wind"
        ];
      };

      input = {
        kb_layout = "se";

        # I prefer using the caps-lock key as my super key
        # so I rebind it to act as a CTRL modifier, and then
        # use the CTRL key as my super-key. In case I need to
        # use the caps-lock function, I rebind double-shift
        # (Left Shift + Right Shift) to act as the caps-lock key.
        kb_options = "shift:both_capslock, caps:ctrl_modifier";

        accel_profile = "flat";

        sensitivity = -0.25;

        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      render = {
        direct_scanout = 1;
      };

      misc = {
        vrr = 1;

        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      layerrule = [
        # Forces blur on anyrun despite it being in the overlay layer
        "blur, (anyrun)"
      ];

      bind = [
        "${superKey}, T, exec, foot"

        "${superKey}, space, exec, anyrun"
        "${superKey}, Q, killactive"

        "${superKey}, h, movefocus, l"
        "${superKey}, l, movefocus, r"
        "${superKey}, j, movefocus, u"
        "${superKey}, k, movefocus, d"

        "${superKey}, 1, workspace, 1"
        "${superKey}, 2, workspace, 2"
        "${superKey}, 3, workspace, 3"
        "${superKey}, 4, workspace, 4"
        "${superKey}, 5, workspace, 5"
        "${superKey}, 6, workspace, 6"
        "${superKey}, 7, workspace, 7"
        "${superKey}, 8, workspace, 8"
        "${superKey}, 9, workspace, 9"
        "${superKey}, 0, workspace, 10"
        "${superKey}, tab, togglespecialworkspace"

        "${superKey}, shift_L, 1, movetoworkspace, 1"
        "${superKey}, shift_L, 2, movetoworkspace, 2"
        "${superKey}, shift_L, 3, movetoworkspace, 3"
        "${superKey}, shift_L, 4, movetoworkspace, 4"
        "${superKey}, shift_L, 5, movetoworkspace, 5"
        "${superKey}, shift_L, 6, movetoworkspace, 6"
        "${superKey}, shift_L, 7, movetoworkspace, 7"
        "${superKey}, shift_L, 8, movetoworkspace, 8"
        "${superKey}, shift_L, 9, movetoworkspace, 9"
        "${superKey}, shift_L, 0, movetoworkspace, 10"
        "${superKey}, shift_L, tab, movetoworkspace, special"

        "${superKey}, F, fullscreen"

        # "${superKey}, shift_L, f4, exit"
        "${superKey}, f4, exec, hyprctl kill"

        # TODO: Display notification!
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy -t image/png"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      bindm = [
        "${superKey}, mouse:272, movewindow"
        "${superKey}, mouse:273, resizewindow 0"
      ];

      binde = [
        ", XF86MonBrightnessUp, exec, blctl increase 10"
        ", XF86MonBrightnessDown, exec, blctl decrease 10"

        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };
}
