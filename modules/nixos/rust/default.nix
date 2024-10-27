{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.rust.enable = lib.mkEnableOption "enable the rust programming tools";
  };

  config = lib.mkIf config.modules.slurp.enable {
    environment.systemPackages = with pkgs; [
      cargo
      rustc
      rust-analyzer
      rustfmt
      clippy
    ];
  };
}
