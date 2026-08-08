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
}
