{
  ...
}:

let
  # Notes to self :3
  # Latency formula: (quantumRate / Hz) x 1000
  # Tested on Intel Core i5-13600K.
  # TODO: Check distortion with gamemode w/ a rate of 384.
  #   Audible distortion still when using gamemode
  #   but only during prolonged sessions?
  # TODO: Check distortion with gamemode esp. during prolonged sessions
  #       with a quantum rate of 448.
  quantumRate = 416;
  quantumRateMin = quantumRate;
  quantumRateMax = quantumRate;
in
{
  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      # Attempt to fix crackling audio issue
      extraConfig.pipewire = {
        "98-crackling-fix" = {
          "context.properties" = {
            "default.clock.allowed-rates" = [
              44100 # Added to fix a crackling audio issue!
              48000
            ];
          };
        };

        "92-low-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = quantumRate;
            "default.clock.min-quantum" = quantumRateMin;
            "default.clock.max-quantum" = quantumRateMax;
          };
        };
      };

      extraConfig.pipewire-pulse = {
        "92-low-latency" = {
          "context.properties" = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = { };
            }
          ];
          "pulse.properties" = {
            "pulse.min.req" = "${toString quantumRateMin}/48000";
            "pulse.default.req" = "${toString quantumRate}/48000";
            "pulse.max.req" = "${toString quantumRateMax}/48000";
            "pulse.min.quantum" = "${toString quantumRateMin}/48000";
            "pulse.max.quantum" = "${toString quantumRateMax}/48000";
          };
          "stream.properties" = {
            "node.latency" = "${toString quantumRate}/48000";
            "resample.quality" = 1;
          };
        };
      };

      # Does not seem necessary?
      # wireplumber.extraConfig = {
      #   "99-crackling-fix" = {
      #     "api.alsa.period-size" = 1024;
      #     "api.alsa.headroom" = 8192;
      #   };
      # };
    };
  };
}
