# Contains system-wide packages that should be installed on all of my hosts.

{
  pkgs,
  ...
}:

{
  imports = [
    ./stylix.nix
    ./greetd.nix
    ./plymouth.nix
  ];

  environment.systemPackages = [
    pkgs.swww
    pkgs.wl-clipboard-rs
  ];
}
