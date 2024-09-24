{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../shared.nix
  ];

  # Todo: Move into shared module
  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = [
    
  ];

  modules = {
    hyprland.enable = true;
    firefox.enable = true;
    pipewire.enable = true;
    openssh.enable = true;
    nix-ld.enable = true;
    vscode-server.enable = true;

    fish = {
      enable = true;
      makeDefault = true;
    };
  };

  system.stateVersion = "24.05";
}
