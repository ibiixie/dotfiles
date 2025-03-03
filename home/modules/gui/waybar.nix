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
        spacing = 16;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "backlight"
          "battery"
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

        "backlight" = {
          interval = 2;
          format = "󰖨 {percent}%";
        };

        "pulseaudio" = {
          format = "{format_source}   {volume}%";
          format-muted = "{format_source}   {volume}%";

          format-source = "";
          format-source-muted = " ";

          tooltip = false;
        };

        "battery" = {
          format = "{icon}  {capacity}%";
          format-charging = "󱐋 {capacity}%";
          format-full = "󱐋 {capacity}%";
          interval = 2;
          states = {
            warning = 30;
            critical = 15;
          };
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
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
          green = base0B;
          yellow = base0A;
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

        window#waybar {
          background-color: transparent;
        }

        window#waybar > box {
          margin: 12px 12px 12px 12px;
          background-color: #${colorScheme.background};
          box-shadow: 0px 0px 6px 0px rgba(0, 0, 0, 1);
          border-radius: 8px;
        }

        #workspaces button.active label {
          border-bottom: 2px solid #${colorScheme.accent};
          padding-top: 2px;
        }

        #workspaces button {
          padding-bottom: 2px;
          border-bottom: 2px solid transparent;
          border-radius: 0;
        }

        #pulseaudio.muted {
          color: #${colorScheme.red};
        }

        #battery.warning:not(.charging) {
          color: #${colorScheme.yellow};
        }

        #battery.critical:not(.charging) {
          color: #${colorScheme.red};
          animation: flash 0.4s steps(12) infinite;
        }

        #battery.full:not(.discharging) {
          color: #${colorScheme.green};
        }

        @keyframes flash {
          50% {
            opacity: 0;
          }
        }

        .modules-right {
          margin-right: 8px;
        }
      '';
  };
}
