{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.fish.enable = lib.mkEnableOption "enable the fish shell";
    modules.fish.makeDefault = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "set the fish shell as the default interactive shell for this user";
    };
  };

  config = lib.mkIf config.modules.fish.enable {
    programs.fish.enable = true;

    users.users."biixie".shell = lib.mkIf config.modules.fish.makeDefault pkgs.fish;
  };
}
