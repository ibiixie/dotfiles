{
  pkgs,
  ...
}:

{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  home.packages = with pkgs; [
    wl-clipboard-rs
  ];

  services.awww = {
    enable = true;
  };

  # main steam window shows a black screen
  # running steam with -system-composer fixes this
  # so i add a new desktop entry to run with that
  #
  # No longer used after I switched to native Wayland mode c:
  # xdg.desktopEntries.steam = {
  #   name = "Steam (Niri)";
  #   exec = "steam -system-composer %U";
  # };

  # Steam sometimes stops working in a way that makes me unable to open
  # my friends list using the Steam UI, so this is a workaround for that.
  xdg.desktopEntries.steam-friends = {
    name = "Steam Friends";
    exec = "xdg-open steam://open/friends";
  };

  xdg.desktopEntries.steam-settings = {
    name = "Steam Settings";
    exec = "xdg-open steam://open/settings";
  };

  xdg.desktopEntries.steam-status-online = {
    name = "Steam Status: Online";
    exec = "xdg-open steam://friends/status/online";
  };

  xdg.desktopEntries.steam-status-invisible = {
    name = "Steam Status: Invisible";
    exec = "xdg-open steam://friends/status/invisible";
  };
}
