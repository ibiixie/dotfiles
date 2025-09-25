{
  lib,
  pkgs,
  ...
}:

{
  # Needed for some GNOME apps (like easyeffects).
  programs.dconf.enable = true;

  programs.uwsm = {
    enable = true;

    waylandCompositors.jay = {
      prettyName = "Jay";
      comment = "Jay compositor";

      # TODO: i think this is bad
      binPath = lib.getExe pkgs.jay + " run";
    };
  };
}
