# Contains system-wide packages that should be installed on all of my hosts.

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./stylix.nix
  ];

  environment.systemPackages = [
    pkgs.swww
    pkgs.wl-clipboard-rs
  ];
}
