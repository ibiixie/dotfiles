# Contains user-level configuration shared across all of my devices and users.

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./modules
  ];

  home.username = "biixie";
  home.homeDirectory = "/home/biixie";

  # No touchy! >:c
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${config.home.username}/.config/sops/age/keys.txt";

    secrets."ssh/personal.pub" = {
      # owner = "${config.home.username}";
    };

    secrets."ssh/personal" = {
      # owner = "${config.home.username}";
    };

    # Todo: Move to biixie.nix?
    /*
    secrets = {
      ssh-personal-public-key = {
        owner = "${config.home.username}";
        # path = "/home/${config.home.username}/.ssh/personal.pub";
        # mode = 644;
      };

      ssh-personal-private-key = {
        # owner = "${config.home.username}";
        # path = "${config.home.username}/.ssh/personal";
        # mode = 600;
      };
    };
    */
  };

  # Enable Wayland for Electron applications.
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      monitor = [
        "eDP-1, 1920x1080@60.00800, 0x0, 1"
      ];

      input = {
        kb_layout = "se";

        sensitivity = -0.25;

        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
      };

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

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

        "SUPERSHIFT, f4, exit,"

        "SUPER, f4, exec, hyprctl kill"

        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ];

      binde = [
        # Todo: Install blctl!
        # ", XF86MonBrightnessUp, exec, blctl increase 10"
        # ", XF86MonBrightnessDown, exec, blctl decrease 10"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };

  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
    };

    foot.enable = true;

    # Todo: Move to separate module!
    git = {
      enable = true;

      lfs.enable = true;

      userEmail = "65206220+ibiixie@users.noreply.github.com";
      userName = "ibiixie";

      signing.signByDefault = true;
      signing.key = "${config.sops.secrets."ssh/personal".path}";

      # Unsure if the below is required with signing.key and signByDefault
      # already set above?
      extraConfig = {
      #   commit.pgpsign = true;
        gpg.format = "ssh";
      #   user.signingkey = "${config.sops.secrets."ssh-personal-public-key".path}";
      };
    };

    firefox.enable = true;

    hyfetch.enable = true;
    fastfetch.enable = true;

    btop.enable = true;
  };
}
