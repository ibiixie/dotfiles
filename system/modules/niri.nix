{
  pkgs,
  ...
}:

{
  programs.niri.enable = true;
  programs.niri.useNautilus = true;

  environment.systemPackages = [
    pkgs.nautilus
    pkgs.xwayland-satellite
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
