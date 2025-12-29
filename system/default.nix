# Contains system-level configuration shared across all of my devices.

{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops

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
    networkmanager.enable = true;
  };

  time = {
    timeZone = "Europe/Stockholm";

    # Conform with Windows.
    hardwareClockInLocalTime = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  console = {
    # Tty keyboard layout.
    keyMap = "sv-latin1";
  };

  # Graphics acceleration.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services = {
    # Keyboard layout.
    xserver.xkb = {
      layout = "se";
      variant = "";
    };

    # Automount external storage devices.
    # TODO: Automount should be disabled on headless systems.
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
      automatic = false;
      options = "--delete-older-than 3d";
    };
  };

  users = {
    mutableUsers = false;
  };

  programs = {
    fish.enable = true;
    git.enable = true;
  };

  environment.systemPackages = [
    pkgs.ripgrep # TODO: Move this to per-user packages?
    pkgs.corefonts
  ];

  # Used by various software for system authentication.
  security.polkit.enable = true;

  virtualisation = {
    docker.enable = true;

    # one day ill get this to work :D
    # podman = {
    #   enable = true;

    #   # Docker compat
    #   dockerCompat = true;
    #   dockerSocket.enable = true;

    #   defaultNetwork.settings.dns_enabled = true;
    # };
  };
}
