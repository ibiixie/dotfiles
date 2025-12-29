{
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./settings.nix
    ./secrets.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.biixie = {
    isNormalUser = true;
    description = "Biixie";

    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];

    hashedPasswordFile = config.sops.secrets."users/biixie/password".path;

    shell = pkgs.fish;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFLXsKzURFCBKU+z45aHd29z99XfmFPn9nc/Pshz+EFN 65206220+ibiixie@users.noreply.github.com"
    ];
  };

  services = {
    tlp = {
      enable = true;

      settings = {
        STOP_CHARGE_THRESH_BAT0 = 80;
        START_CHARGE_THRESH_BAT0 = 40;
      };
    };

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

    blctl.enable = true;
  };

  networking.hostName = "twinkpad";
  networking.firewall.allowedTCPPorts = [ 21622 ];

  hardware.enableAllFirmware = true;
  hardware.enableAllHardware = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
