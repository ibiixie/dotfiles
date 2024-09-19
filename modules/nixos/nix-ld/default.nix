{
  config,
  lib,
  pkgs,
  nix-ld,
  ...
}: let
  
in {
  options = {
    modules.nix-ld.enable = lib.mkEnableOption "enable nix-ld to allow running dynamic libs";
  };

  config = lib.mkIf config.modules.nix-ld.enable {
    programs.nix-ld.enable = true;
  };
}
