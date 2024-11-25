{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.steam.enable = lib.mkEnableOption "enable Steam";
  };

  config = lib.mkIf config.modules.steam.enable {
    programs.steam = {
      enable = true;

      # remotePlay.openFirewall = true;
      # dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;

      gamescopeSession.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
