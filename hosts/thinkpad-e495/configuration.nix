{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  # Todo: Move into shared module
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Todo: Turn into module!
  modules = {
    hyprland.enable = true;
  };


  system.stateVersion = "24.05";
}
