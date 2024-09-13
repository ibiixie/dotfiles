{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.foot.enable = lib.mkEnableOption "enable foot";
    
    modules.foot.font = lib.mkOption {
      type = lib.types.str;
      default = "monospace";
      description = "the font to use in the foot terminal window";
    };

    modules.foot.fontSize = lib.mkOption {
      type = lib.types.int;
      default = 12;
      description = "the font size to use in the foot terminal window";
    };

    modules.foot.pad.x = lib.mkOption {
      type = lib.types.int;
      default = 8;
      description = "the padding to use on the left and right sides of the terminal window";
    };

    modules.foot.pad.y = lib.mkOption {
      type = lib.types.int;
      default = 8;
      description = "the padding to use on the top and bottom sides of the terminal window";
    };
  };

  config = lib.mkIf config.modules.foot.enable {
    home.packages = [
    ];

    programs.foot = {
      enable = true;

      settings = {
        main = {
          dpi-aware = "yes";
	  font = lib.mkIf (config.modules.foot.font != "") (config.modules.foot.font + ":size=" + (toString config.modules.foot.fontSize));
	  pad = (toString config.modules.foot.pad.x) + "x" + (toString config.modules.foot.pad.y);
        };
      };
    };
  };
}
