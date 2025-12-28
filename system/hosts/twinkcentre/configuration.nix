# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./secrets.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "twinkcentre";

  networking.firewall.allowedTCPPorts = [ 22 ];

  hardware.enableAllFirmware = true;
  hardware.enableAllHardware = true;

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

  users.users.gitea-runner = {
    isNormalUser = true;
    extraGroups = [
      "docker"
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

    github-runners = {
      twinkcentre-runner = {
        enable = true;
        name = "twinkcentre-runner";
        # TODO: Don't think this URL is correct.
        url = "https://github.com/ibiixie/dedicated-infra";
        user = "biixie";
        tokenFile = config.sops.secrets."hosts/twinkcentre/gh-runner-token".path;
        extraPackages = [ pkgs.docker ];
      };
    };

    gitea-actions-runner = {
      package = pkgs.forgejo-runner;

      instances.twinkcentre = {
        enable = true;
        name = "twinkcentre-runner";
        url = "https://codeberg.org/";
        labels = [
          "self-hosted:host"
          "twinkcentre:host"
        ];
        tokenFile = config.sops.secrets."hosts/twinkcentre/codeberg-runner-token".path;
        hostPackages = with pkgs; [
          bash
          coreutils
          curl
          gawk
          gitMinimal
          gnused
          nodejs
          wget
          docker
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
  system.stateVersion = "25.05"; # Did you read the comment?

}
