{
  pkgs,
  ...
}:

{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  # main steam window shows a black screen
  # running steam with -system-composer fixes this
  # so i add a new desktop entry to run with that
  xdg.desktopEntries.steam = {
    name = "Steam (Niri)";
    exec = "steam -system-composer %U";
  };
}
