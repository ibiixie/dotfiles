{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules
    ./secrets.nix
  ];

  home.username = "biixie";
  home.homeDirectory = "/home/biixie";

  # No touchy! >:c
  home.stateVersion = "24.11";

  home.sessionVariables.NIXOS_OZONE_WL = "1";

  systemd.user.startServices = "sd-switch";

  home.packages = with pkgs; [
    grim
    slurp
    just
  ];

  programs = {
    home-manager.enable = true;
    btop.enable = true;
  };
}
