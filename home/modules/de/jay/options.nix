{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkIf
    mkOption
    types
    ;
  cfg = config.wayland.windowManager.jay;
in
{
  options.wayland.windowManager.jay = {
    enable = lib.mkEnableOption "jay window manager";
    package = lib.mkPackageOption pkgs "jay" { example = "pkgs.jay"; };

    systemd = {
      enable = lib.mkEnableOption null // {
        default = false;
        description = "";
      };

      variables = lib.mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "--all" ];
        description = "";
      };

      extraCommands = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile = {
      "jay/config.toml" = {
        source =
          let
            configFile = ./config.toml;
          in
          pkgs.runCommand "jay-config.toml" { } ''
            cat ${configFile} >> $out
          '';
      };
    };
  };
}
