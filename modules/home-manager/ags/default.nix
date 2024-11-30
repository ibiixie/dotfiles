{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [ inputs.ags.homeManagerModules.default ];

  options = {
    modules.ags.enable = lib.mkEnableOption "enable ags";
  };

  config = lib.mkIf config.modules.ags.enable {
    programs.ags = {
      enable = true;

      configDir = ./config;

      extraPackages = with pkgs; [
        gtksourceview
	      webkitgtk
	      accountsservice

        # Astal libs
        inputs.ags.packages.${pkgs.system}.battery
      ];
    };
  };
}
