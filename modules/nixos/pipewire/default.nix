{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.pipewire.enable = lib.mkEnableOption "enable the pipewire audio service";
  };

  config = lib.mkIf config.modules.pipewire.enable {
    services.pipewire = {
      enable = true;
      audio.enable = true;

      wireplumber.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
  };
}
