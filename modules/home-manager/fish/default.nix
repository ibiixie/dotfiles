{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.zed-editor.enable = lib.mkEnableOption "enable zed";
  };

  config = lib.mkIf config.modules.git.enable {
    programs.fish = {
      enable = true;

      shellAliases = {
        "pls" = "sudo";
	"please" = "sudo";

	".." = "cd ..";
      };

      functions = {
        fish_greeting = ''
          
	'';

	fish_prompt = ''
          set -g __fish_get_prompt_showupstream auto

	  echo \
	  (set_color brmagenta)$USER@$hostname \
	  (set_color yellow)(prompt_pwd) \
	  (set_color red)(fish_vcs_prompt) \
	  (set_color cyan)"ε> "
	'';
      };
    };
  };
}

