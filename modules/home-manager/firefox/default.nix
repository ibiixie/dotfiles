{ inputs, config, lib, pkgs, ... }:

{
  options = {
    modules.firefox.enable = lib.mkEnableOption "enable firefox - remember to enable the system-wide firefox module too!";
  };

  config =  lib.mkIf config.modules.firefox.enable {
    home.packages = [

    ];

    programs.firefox = {
      enable = true;
      
      profiles.default-release = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
	  bitwarden
	  bypass-paywalls-clean
	  return-youtube-dislikes
	  languagetool
	  youtube-shorts-block
        ];

	settings = [
          
	];

        search.default = "DuckDuckGo";
	search.privateDefault = "DuckDuckGo";
	search.force = true;

	isDefault = true;
      };
    };
  };
}
