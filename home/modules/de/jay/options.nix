{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    literalExpression
    mkIf
    mkOption
    types
    ;

  cfg = config.wayland.windowManager.jay;
  tomlFormat = pkgs.formats.toml { };
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

    extraConfig = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Extra lines to append to the config file.
      '';
      example = literalExpression ''
        # TODO: Add example
      '';
    };

    settings = mkOption {
      type = tomlFormat.type;
      default = { };
      example = literalExpression ''
        # TODO: Add example
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile =
      let
        hasSettings = cfg.settings != { };
        hasExtraConfig = cfg.extraConfig != "";
      in
      {
        "jay/config.toml" = mkIf (hasSettings || hasExtraConfig) {
          source =
            let
              configFile = tomlFormat.generate "config.toml" cfg.settings;
              extraConfigFile = pkgs.writeText "extra-config.toml" (
                lib.optionalString hasSettings "\n" + cfg.extraConfig
              );
            in
            pkgs.runCommand "jay-config.toml" { } ''
              cat ${configFile} ${extraConfigFile} >> $out
            '';
        };
      };
  };
}
