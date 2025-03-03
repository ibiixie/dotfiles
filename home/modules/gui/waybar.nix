{
  config,
  pkgs,
  ...
}:

{
  # This causes some conflicts with custom waybar styling
  # so I disable the waybar target for stylix. It will still
  # use the GTK styling as a fallback anyway so it'll look
  # okay even if left unstyled.
  stylix.targets.waybar.enable = false;

  home.packages = [
    pkgs.libappindicator
  ];

  programs.waybar = {
    enable = true;

    # Automatically run Waybar with the configured wayland session.
    systemd.enable = true;

    settings = {
      mainBar = {
        # Spacing between modules in pixels.
        spacing = 16;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
          "mpd"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "wireplumber"
          "tray"
        ];

        "clock" = {
          interval = 1;
          format = "{:%A %m/%d %H:%M:%S %Z (%Oz)}";
          tooltip-format = "{tz_list}";
          timezones = [
            "Europe/Stockholm"
            "Etc/UTC"
            "Asia/Tokyo"
            "America/Halifax"
          ];
        };

        "wireplumber" = {
          "format" = "  {volume}%";
          "format-muted" = "  {volume}%";
        };

        "tray" = {
          icon-size = 20;
          spacing = 10;
          show-passive-items = true;
        };

        "hyprland/window" = {
          separate-outputs = true;
          format = "{}";
          rewrite = {
            "(.*) — Mozilla Firefox" = "Firefox — $1";
            "(.*) - fish" = "><()> [$1]";
          };
        };

        "hyprland/submap" = {
          default-submap = "default";
          always-on = true;
          tooltip = false;
        };
      };
    };

    style =
      let
        colorScheme = with config.stylix.base16Scheme; {
          background = base00;
          accent = base0E;
          text = base05;
          hover = base02;
          red = base08;
        };
      in
      # css
      ''
        * {
          font-family: "Agave Nerd Font";
          font-size: 18;
          font-weight: bold;
          color: #${colorScheme.accent};
        }

        #workspaces button.active {
          border-bottom: 2px solid #${colorScheme.accent};
        }

        #workspaces button {
          padding-bottom: 2px; /* compensate for border - 3px looks uneven */
          border-bottom: 3px solid transparent;
          border-radius: 0;
        }

        #wireplumber.muted {
          color: #${colorScheme.red};
        }

        #tray {
          margin-right: 8px;
        }
      '';
  };
}
