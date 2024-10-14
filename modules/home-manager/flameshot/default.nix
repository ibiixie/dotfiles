{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.flameshot.enable = lib.mkEnableOption "enable the flameshot screenshotting tool";
  };

  config = lib.mkIf config.modules.flameshot.enable {
    services.flameshot = {
      enable = true;

      settings = {
        General = {
          disabledTrayIcon = true;
	  showStartupLaunchMessage = false;

	  showHelp = false;

	  # I have no notification daemon, might have to disable?
	  showDesktopNotification = false;	  
	};
      };
    };
  };
}
