{ inputs, config, lib, pkgs, ... }:

{
  options = {
    modules.foot.enable = lib.mkEnableOption "enable foot";
  };

  config =  lib.mkIf config.modules.foot.enable {
    home.packages = [

    ];

    programs.foot = {
      enable = true;
      
      settings = {
        main = {
          dpi-aware = "yes";
	};
      };
    };
  };
}
