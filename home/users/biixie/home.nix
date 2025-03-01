{
  pkgs,
  ...
}:

{
  imports = [
    ../../modules
  ];

  home.username = "biixie";
  home.homeDirectory = "/home/biixie";

  # No touchy! >:c
  home.stateVersion = "24.11";

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  systemd.user.startServices = "sd-switch";

  home.packages = [
    pkgs.grim
    pkgs.slurp
  ];

  programs = {
    home-manager.enable = true;

    btop.enable = true;
  };
}
