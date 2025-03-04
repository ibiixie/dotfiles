{
  osConfig,
  pkgs,
  ...
}:

let
  superKey = "SUPER";
in

{
  home.packages = [
    pkgs.wl-clipboard-rs

    # Not sure if it's needed but no harm in adding it anyway :p
    pkgs.kdePackages.xwaylandvideobridge
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;

    # Disable since I have withUWSM enabled.
    # https://wiki.hyprland.org/Useful-Utilities/Systemd-start/
    systemd.enable = false;

    settings = {
      general = {
        allow_tearing = true;
        resize_on_border = true;

        border_size = 2;
      };

      monitor = with osConfig.settings.display; [
        "${toString source}, ${toString resolution.width}x${toString resolution.height}@${toString refreshRate}, ${toString position.x}x${toString position.y}, ${toString scale}"

        # Fix for gap when bar uses transparent background and padding.
        # TODO: This should probably be in the bar module?
        "${toString source}, addreserved, -12, 0, 0, 0"
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
        kb_options = "shift:both_capslock, caps:super";

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
        # Submap triggers
        "${superKey}, m, submap, move"
        "${superKey}, r, submap, resize"
        "${superKey}, w, submap, workspace"

        # Global binds
        "${superKey}, t, exec, foot"
        "${superKey}, space, exec, anyrun"
        "${superKey}, Q, killactive"
        "${superKey} & Alt, F, fullscreen"
        "${superKey}, f4, exec, hyprctl kill"

        "${superKey}, h, movefocus, l"
        "${superKey}, j, movefocus, d"
        "${superKey}, k, movefocus, u"
        "${superKey}, l, movefocus, r"

        # All other special workspace binds are in the workspace
        # submap in the extraConfig section at the bottom!
        "${superKey}, tab, togglespecialworkspace"

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

    extraConfig = ''
      submap = move
        binde = , h, movewindow, l
        binde = , j, movewindow, d
        binde = , k, movewindow, u
        binde = , l, movewindow, r

        bind = , escape, submap, reset
      submap = reset

      submap = resize
        binde = , h, resizeactive, -20   0
        binde = , j, resizeactive,   0  20
        binde = , k, resizeactive,   0 -20
        binde = , l, resizeactive,  20   0

        bind = , escape, submap, reset
      submap = reset

      submap = workspace
        bind = , 1, workspace, 1
        bind = , 2, workspace, 2
        bind = , 3, workspace, 3
        bind = , 4, workspace, 4
        bind = , 5, workspace, 5
        bind = , 6, workspace, 6
        bind = , 7, workspace, 7
        bind = , 8, workspace, 8
        bind = , 9, workspace, 9
        bind = , 0, workspace, 10

        bind = Alt, tab, movetoworkspace, special
        bind = Alt, 1, movetoworkspace, 1
        bind = Alt, 2, movetoworkspace, 2
        bind = Alt, 3, movetoworkspace, 3
        bind = Alt, 4, movetoworkspace, 4
        bind = Alt, 5, movetoworkspace, 5
        bind = Alt, 6, movetoworkspace, 6
        bind = Alt, 7, movetoworkspace, 7
        bind = Alt, 8, movetoworkspace, 8
        bind = Alt, 9, movetoworkspace, 9
        bind = Alt, 9, movetoworkspace, 10

        bind = , escape, submap, reset
      submap = reset
    '';
  };
}
