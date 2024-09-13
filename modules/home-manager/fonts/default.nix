{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./iosevka
  ];

  options = {
    modules.fonts = {
      enable = lib.mkEnableOption "enable font configuration";
    
      defaults = {
        monospace = lib.mkOption {
          type = lib.types.listOf lib.types.str;
	  default = [  ];
	  description = "a list of fonts to set as the default monospace fonts for this user";
	};

	sansSerif = lib.mkOption {
          type = lib.types.listOf lib.types.str;
	  default = [ ];
	  description = "a list of fonts to set as the default sans-serif fonts for this user";
	};

	serif = lib.mkOption {
          type = lib.types.listOf lib.types.str;
	  default = [ ];
	  description = "a list of fonts to set as the default serif fonts for this user";
	};
      };
    };
  };

  config = lib.mkIf config.modules.fonts.enable {
    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
        monospace = config.modules.fonts.defaults.monospace;
        sansSerif = config.modules.fonts.defaults.sansSerif;
        serif = config.modules.fonts.defaults.serif;
      };
    };
  };
}
