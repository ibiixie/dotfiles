{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  
in {
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  # Todo: Move into shared module
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  networking.wireless.iwd = {
    enable = true;

    settings.Settings = {
      AutoConnect = true;
    };
  };

  networking.networkmanager.wifi.backend = "iwd";

  environment.systemPackages = [
    # pkgs.blctl
    pkgs.pwvucontrol
  ];

  modules = {
    hyprland.enable = true;
    firefox.enable = true;
    pipewire.enable = true;
    openssh.enable = true;
    nix-ld.enable = true;

    wl-clipboard.enable = true;
    grim.enable = true;
    slurp.enable = true;

    vesktop.enable = true;

    obsidian.enable = true;

    fish = {
      enable = true;
      makeDefault = true;
    };
  };

  services.blctl.enable = true;

  system.stateVersion = "24.05";
}
