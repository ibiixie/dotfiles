{ pkgs, lib, inputs, outputs ...  }:

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

  # Packages go here!
  # packagename.enable = true;


  system.stateVersion = "24.05";
}

