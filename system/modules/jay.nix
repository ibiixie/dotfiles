{
  lib,
  pkgs,
  ...
}:

{
  # Needed for some GNOME apps (like easyeffects).
  programs.dconf.enable = true;

  programs.xwayland.enable = true;

  # required when using home-manager with userUserPackages enabled
  # https://mynixos.com/home-manager/option/xdg.portal.enable
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  xdg.portal = {
    enable = true;
    configPackages = [
      pkgs.jay
    ];
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  services.displayManager.sessionPackages = [
    pkgs.jay
  ];

  programs.uwsm = {
    enable = true;

    waylandCompositors.jay = {
      prettyName = "Jay";
      comment = "Jay compositor";

      extraArgs = [
        "run"
      ];

      binPath = "/run/current-system/sw/bin/jay";
    };
  };
}
