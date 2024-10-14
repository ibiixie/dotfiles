{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.neovim.enable = lib.mkEnableOption "enable neovim";
    modules.neovim.defaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "set neovim to the default editor using  the EDITOR env var";
    };
  };

  config = lib.mkIf config.modules.git.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = config.modules.neovim.defaultEditor;
    };
  };
}
