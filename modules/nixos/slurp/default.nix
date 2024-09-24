{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.slurp.enable = lib.mkEnableOption "enable the slurp tool";
  };

  config = lib.mkIf config.modules.slurp.enable {
    environment.systemPackages = with pkgs; [
      slurp
    ];
  };
}
