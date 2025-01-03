{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.fuzzel.enable = lib.mkEnableOption "enable fuzzel";
  };

  config = lib.mkIf config.modules.fuzzel.enable {
    programs.fuzzel = {
      enable = true;

      settings = {
        main = {
	  terminal = "${pkgs.foot}/bin/foot";
	  layer = "overlay";
	  use-bold = "yes";
	  placeholder = "hi :3";
	  icons-enabled = "no";
	};

	colors = {
          background="24273add";
          text="cad3f5ff";
          prompt="b8c0e0ff";
          placeholder="8087a2ff";
          input="cad3f5ff";
          match="f5bde6ff";
          selection="5b6078ff";
          selection-text="cad3f5ff";
          selection-match="f5bde6ff";
          counter="8087a2ff";
          border="f5bde6ff";
	};
      };
    };
  };
}
