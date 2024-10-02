{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.obsidian.enable = lib.mkEnableOption "enable the Obsidian markdown note editor";
  };

  config = lib.mkIf config.modules.obsidian.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
