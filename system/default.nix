# Contains system-level configuration shared across all of my devices.

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./modules
  ];

  boot.supportedFilesystems = [
    "ntfs"
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time = {
    timeZone = "Europe/Stockholm";

    # Conform with Windows.
    hardwareClockInLocalTime = true;
  };

  # Tty keyboard layout.
  console.keyMap = "sv-latin1";

  # Graphics acceleration.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services = {
    # Keyboard layout.
    xserver.xkb.layout = "se";

    # Automount external storage devices.
    devmon.enable = true;
    gvfs.enable = true;
    udisks2.enable = true;
  };

  # Enable support for Nix flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.biixie = {
    shell = pkgs.fish;
    isNormalUser = true;
    description = "Biixie";
    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];
  };

  programs = {
    fish.enable = true;

    hyprland.enable = true;

    git.enable = true;
  };

  # Used by various software for system authentication.
  security.polkit.enable = true;
}
