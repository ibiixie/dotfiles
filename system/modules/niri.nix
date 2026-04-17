{
  pkgs,
  ...
}:

{
  programs.niri.enable = true;
  programs.niri.useNautilus = true;

  environment.systemPackages = [
    pkgs.xwayland-satellite
    pkgs.nautilus
  ];

  # programs.uwsm = {
  #   enable = true;
  #   waylandCompositors.niri = {
  #     prettyName = "Niri";
  #     comment = "Niri Wayland compositor";
  #     binPath = "/run/current-system/sw/bin/niri";
  #     extraArgs = [
  #       "--session"
  #     ];
  #   };
  # };
}
