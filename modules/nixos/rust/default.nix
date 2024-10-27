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
      unstable.cargo
      unstable.rustc
      unstable.rust-analyzer
      unstable.rustfmt
      unstable.clippy
    ];
  };
}
