{ config, lib, pkgs, ... }:

{
  options = {
    modules.zed-editor.enable = lib.mkEnableOption "enable zed";
  };

  config =  lib.mkIf config.modules.git.enable {
    home.packages = [
      pkgs.unstable.zed-editor
    ];
  };
}

# Notes
#
# Settings
#  - Located at `$XDG_CONFIG_HOME/zed/settings.json` if set in path, or `~/.config/zed/settings.json`
#  - The themes are located in the same directory, but instead of settings.json it's in `themes` directory
#
# Extensions
#  - Installed in `$XDF_DATA_HOME/zed/extensions` (if in path) or `~/.local/share/zed/extensions`
#  - In the above path, the `installed` directory and the `index.json` files need to be created by nix
