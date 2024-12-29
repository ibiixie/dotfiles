{
  config,
  lib,
  pkgs,
  ...
}: let
  
in {
  options = {
    modules.tlp.enable = lib.mkEnableOption "enable the tlp power-management tool";
  };

  config = lib.mkIf config.modules.tlp.enable {
    services.tlp = {
      enable = true;
      settings = {
        STOP_CHARGE_THRESH_BAT0 = 80;

	CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;
      };
    };
  };
}
