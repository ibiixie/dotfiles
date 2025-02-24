{
  ...
}:

{
  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      general = {
        allow_tearing = true;
        resize_on_border = true;
      };

      monitor = [
        "eDP-1, 1920x1080@60.00800, 0x0, 1"
        "DP-4, 2560x1440@164.84, 0x0, 1"
      ];

      dwindle = {
        preserve_split = true;
        pseudotile = true;
      };

      decoration = {
        rounding = 10;
        active_opacity = 0.8; # 0.9
        inactive_opacity = 0.7; # 0.8
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
        "SUPER, Q, exec, foot"
        "SUPER, C, killactive"

        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, j, movefocus, u"
        "SUPER, k, movefocus, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER, tab, togglespecialworkspace"

        "SUPERSHIFT, 1, movetoworkspace, 1"
        "SUPERSHIFT, 2, movetoworkspace, 2"
        "SUPERSHIFT, 3, movetoworkspace, 3"
        "SUPERSHIFT, 4, movetoworkspace, 4"
        "SUPERSHIFT, 5, movetoworkspace, 5"
        "SUPERSHIFT, 6, movetoworkspace, 6"
        "SUPERSHIFT, 7, movetoworkspace, 7"
        "SUPERSHIFT, 8, movetoworkspace, 8"
        "SUPERSHIFT, 9, movetoworkspace, 9"
        "SUPERSHIFT, 0, movetoworkspace, 10"
        "SUPERSHIFT, tab, movetoworkspace, special"

        "SUPER, space, exec, anyrun"

        "SUPER, F, fullscreen"

        "SUPERSHIFT, f4, exit"
        "SUPER, f4, exec, hyprctl kill"

        # TODO: Display notification!
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy -t image/png"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow 0"
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
