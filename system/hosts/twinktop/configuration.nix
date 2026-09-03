{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./audio

    ./settings.nix
    ./secrets.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # For games mainly :D
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # QuickSync/VAAPI is mostly broken on Alchemist GPUs when using the
  # newer `xe` graphics driver due to lack of HuC support. This patch
  # implements support for the GPU to enable QuickSync/VAAPI properly.
  boot.kernelPatches = [
    {
      name = "xe-dg2-huc-mei";
      patch = pkgs.fetchpatch2 {
        url = "https://gitlab.freedesktop.org/drm/xe/kernel/-/commit/4fc0ff994edb4e1e6c00e42ea2ac6d72a3c27efb.patch";
        hash = "sha256-yvnAtOeozZQcbVhv7pdpADHLKJsEAQvvxlO4dgWfZ7Q=";
      };
    }
  ];

  powerManagement.cpuFreqGovernor = "performance";

  hardware.enableAllFirmware = true;
  hardware.enableAllHardware = true;

  networking.hostName = "twinktop";
  networking.firewall.allowedTCPPorts = [
    21622
    26900
  ];
  networking.firewall.allowedUDPPorts = [
    26900
    26901
    26902
  ];

  # Quad9 DoH
  networking = {
    nameservers = [
      "127.0.0.1"
      "::1"
    ];
    dhcpcd.extraConfig = "nohook resolv.conf";
    networkmanager.dns = "none";
  };

  services.dnscrypt-proxy = {
    enable = true;
    settings = {
      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
        cache_file = "/var/lib/dnscrypt-proxy/public-resolvers.md";
      };

      ipv6_servers = true;
      block_ipv6 = false;

      require_dnssec = true;
      require_nolog = true;

      server_names = [
        "quad9-doh-ip4-port443-nofilter-pri"
        "quad9-doh-ip6-port443-nofilter-pri"
      ];
    };
  };

  # TODO: Move this?
  programs.nix-ld.enable = true;

  hardware.graphics.extraPackages = [
    pkgs.intel-media-driver
    pkgs.vpl-gpu-rt
    pkgs.intel-compute-runtime
  ];

  # Probably not used, but might as well c:
  services.xserver.videoDrivers = [ "modesetting" ];

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  boot.kernelParams = [
    "i915.force_probe=!56a0"
    "xe.force_probe=56a0"
  ];

  fileSystems."/Storage" = {
    device = "/dev/disk/by-uuid/B2783C05783BC6BF";
    fsType = "ntfs-3g";
    options = [
      "noatime"
      "nofail"
      "rw"
      "uid=1000"
    ];
  };

  fileSystems."/Archive" = {
    device = "/dev/disk/by-uuid/94A4EB75A4EB57EE";
    fsType = "ntfs-3g";
    options = [
      "noatime"
      "nofail"
      "rw"
      "uid=1000"
    ];
  };

  fileSystems."/Dying-Archive" = {
    device = "/dev/disk/by-uuid/509C44B39C4494FE";
    fsType = "ntfs-3g";
    options = [
      "noatime"
      "nofail"
      "rw"
      "uid=1000"
    ];
  };

  users.users.biixie = {
    isNormalUser = true;
    description = "Biixie";

    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
      "gamemode"
      "audio"
    ];

    hashedPasswordFile = config.sops.secrets."users/biixie/password".path;

    shell = pkgs.fish;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0hpm4wxNoqYj4MLqjZtUDs095vcgG7Wukb0uDryCZH"
    ];
  };

  services = {
    openssh = {
      enable = true;
      ports = [ 21622 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AllowUsers = [
          "*@192.168.1.*"
        ];
      };
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
