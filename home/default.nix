# Contains user-level configuration shared across all of my devices and users.

{
  pkgs,
  ...
}:

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

  # Enable Wayland for Electron applications.
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = [
    pkgs.grim
    pkgs.slurp
  ];

  programs = {
    btop.enable = true;
  };
}
