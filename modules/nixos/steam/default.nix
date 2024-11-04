{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.steam.enable = lib.mkEnableOption "enable Steam";
    modules.steam.gamescope.enable = lib.mkEnableOption "enable Steam's gamescope compositor";
  };

  config = lib.mkIf config.modules.steam.enable {
    programs.steam = {
      enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      gamescopeSession.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    hardware.xone.enable = true;
    services.getty.autologinUser = "biixie";

    environment = {
      systemPackages = [
        pkgs.mangohud
      ];

      loginShellInit = ''
        [[ $(tty) = "/dev/tty1" ]] && ./gs.sh
      '';
    };
  };

  # config = lib.mkIf config.modules.steam.gamescope.enable {
  #   programs.steam.gamescopeSession.enable = true;

  #   programs.gamescope = {
  #     enable = true;
  #     capSysNice = true;
  #   };

  #   hardware.xone.enable = true;
  #   services.getty.autoLoginUser = "biixie";

  #   environment = {
  #     systemPackages = pkgs.mangohud;
  #     loginShellInit = ''
  # 	[[ $(tty) = "/dev/tty1" ]] && ./gs.sh
  #     '';
  #   };
  # };
}
