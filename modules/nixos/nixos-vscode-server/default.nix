{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.vscode-server.enable = lib.mkEnableOption "enable a custom vscode server with NixOS support";
  };

  config = lib.mkIf config.modules.vscode-server.enable {
    services.vscode-server = {
      enable = true;
    };
  };
}
