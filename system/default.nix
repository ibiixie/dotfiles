# Contains system-level configuration shared across all of my devices.

{
  pkgs,
  ...
}:

{
  imports = [
    ./settings.nix
    ./modules
  ];

  boot.supportedFilesystems = [
    "ntfs"
  ];

  # Fixes an issue with Plymouth's logo being resized and
  # repositioned in the middle of the boot sequence.
  boot.loader.systemd-boot.consoleMode = "0";

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time = {
    timeZone = "Europe/Stockholm";

    # Conform with Windows.
    hardwareClockInLocalTime = true;
  };

  console = {
    # Tty keyboard layout.
    keyMap = "sv-latin1";
  };

  i18n = {
    extraLocaleSettings = {
      LC_TIME = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
    };
  };

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

    fstrim.enable = true;
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 3d";
    };
  };

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

  environment.systemPackages = [
    pkgs.ripgrep

    pkgs.corefonts
  ];

  # Used by various software for system authentication.
  security.polkit.enable = true;

  virtualisation.docker.enable = true;
}
