# Contains system-wide configuration shared across all hosts
{ config, pkgs, inputs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Todo: Move locale stuff to separate module?
  time.timeZone = "Europe/Stockholm";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocalteSettings = {
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

  services.xserver = {
    layout = "se";
    xkbVariant = "";
  };

  # Remove preinstalled packages
  environment.defaultPackages = [  ];

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    extraOptions = {
      experimental-features = [ "experimental-features" "flakes" ]
    };
  };
}
