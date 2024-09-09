{
  config,
  pkgs,
  inputs,
  ...
}:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Todo: Move user stuff to separate module?
  users.users.biixie = {
    isNormalUser = true;
    description = "Biixie";
    password = "136192";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  users.mutableUsers = false;

  # Todo: Move locale stuff to separate module?
  time.timeZone = "Europe/Stockholm";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF8";
    LC_IDENTIFICATION = "sv_SE.UTF8";
    LC_MEASUREMENT = "sv_SE.UTF8";
    LC_MONETARY = "sv_SE.UTF8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF8";
    LC_PAPER = "sv_SE.UTF8";
    LC_TELEPONE = "sv_SE.UTF8";
    LC_TIME = "sv_SE.UTF8";
  };

  console.keyMap = "sv-latin1";

  services.xserver.xkb = {
    layout = "se";
    variant = "";
  };

  # Remove preinstalled packages
  environment.defaultPackages = [  ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];

    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}

