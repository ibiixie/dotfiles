# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops

    ./secrets.nix

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Server is currently connected to a vertical monitor
  boot.kernelParams = [
    "fbcon=rotate:1"
  ];

  networking = {
    hostName = "twinkcentre";
    networkmanager.enable = true;

    firewall.allowedTCPPorts = [
      22
      21622
    ];
  };

  hardware.enableAllFirmware = true;
  hardware.enableAllHardware = true;

  users.mutableUsers = false;

  programs = {
    fish.enable = true;
    git.enable = true;

    ssh = {
      extraConfig = ''
        Host dotfiles
          HostName codeberg.org
          User git
          IdentityFile ${config.sops.secrets."hosts/twinkcentre/dotfiles-deploy-key".path}
          IdentitiesOnly yes
      '';
    };

    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 5 --keep-since 3d";
        dates = "weekly";
      };
    };
  };

  environment.systemPackages = [ ];

  users.users.twinkcentre = {
    isNormalUser = true;
    description = "Twinkcentre";

    extraGroups = [
      "wheel"
      "networkmanager"
      "docker"
    ];

    hashedPasswordFile = config.sops.secrets."hosts/twinkcentre/password".path;

    shell = pkgs.fish;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG0hpm4wxNoqYj4MLqjZtUDs095vcgG7Wukb0uDryCZH"
    ];
  };

  users.users.gitea-runner = {
    isNormalUser = true;
    extraGroups = [
      "docker"
    ];
  };

  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    dates = "daily";
    flake = "git+https://codeberg.org/biixie/dotfiles#twinkcentre";
    flags = [
      # All other inputs are unused by the server
      "--update-input"
      "nixpkgs-server"
    ];
    runGarbageCollection = true;
  };

  systemd.services.nixos-upgrade-notify-failure = {
    script = ''
      ${pkgs.curl}/bin/curl -s \
        --form-string "token=$PUSHOVER_TOKEN" \
        --form-string "user=$PUSHOVER_USER" \
        --form-string "message=NixOS server upgrade failed on $(hostname)" \
        https://api.pushover.net/1/messages.json
    '';
    serviceConfig = {
      Type = "oneshot";
      EnvironmentFile = config.sops.secrets."hosts/twinkcentre/pushover-credentials".path;
    };
  };

  systemd.services.nixos-upgrade.serviceConfig.OnFailure = "nixos-upgrade-notify-failure.service";

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      auto-optimise-store = true;
    };
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

    # Reduce font size
    earlySetup = true;
    font = "ter-u18b";
    packages = [ pkgs.terminus_font ];
  };

  # Used by various software for system authentication.
  security.polkit.enable = true;

  # Real-time scheduling
  security.rtkit.enable = true;

  virtualisation = {
    docker.enable = true;
  };

  # Graphics acceleration.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
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

    # gitea-actions-runner = {
    #   package = pkgs.forgejo-runner;

    #   instances.twinkcentre = {
    #     enable = true;
    #     name = "twinkcentre-runner";
    #     url = "https://codeberg.org/";
    #     labels = [
    #       "self-hosted:host"
    #       "twinkcentre:host"
    #     ];
    #     tokenFile = config.sops.secrets."hosts/twinkcentre/codeberg-runner-token".path;
    #     hostPackages = with pkgs; [
    #       bash
    #       coreutils
    #       curl
    #       gawk
    #       gitMinimal
    #       gnused
    #       nodejs
    #       wget

    #       docker
    #     ];
    #   };
    # };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
