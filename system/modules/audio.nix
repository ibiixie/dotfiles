{
  ...
}:

let
  mkQuantumRate = quantum: rate: "${toString quantum}/${toString rate}";

  baseQuantum = 256;
  minQuantum = 256;
  maxQuantum = 384; # 384
  rate = 48000;

  baseQuantumRate = mkQuantumRate baseQuantum rate;
  minQuantumRate = mkQuantumRate minQuantum rate;
  maxQuantumRate = mkQuantumRate maxQuantum rate;
in
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig = {
      pipewire."99-pipewire-lowlatency" = {
        "context.properties" = {
          "default.clock.rate" = rate;
          "default.clock.quantum" = baseQuantum;
          "default.clock.min-quantum" = minQuantum;
          "default.clock.max-quantum" = maxQuantum;
        };

        "default.clock.allowed-rates" = [
          32000
          44100
          48000
          96000
          192000
        ];

        "context.modules" = [
          {
            name = "libpipewire-module-rt";
            flags = [
              "ifexists"
              "nofail"
            ];
            args = {
              "nice.level" = -20;
              "rt.prio" = 99;
              "rt.time.soft" = 200000;
              "rt.time.hard" = 200000;
            };
          }
        ];
      };

      pipewire-pulse."99-pulse-lowlatency" = {
        "pulse.properties" = {
          "server.address" = [ "unix:native" ];
          "pulse.default.req" = baseQuantumRate;
          "pulse.default.quantum" = baseQuantumRate;
          "pulse.default.frag" = baseQuantumRate;
          "pulse.min.req" = minQuantumRate;
          "pulse.min.quantum" = minQuantumRate;
          "pulse.min.frag" = minQuantumRate;
          "pulse.max.req" = maxQuantumRate;
          "pulse.max.quantum" = maxQuantumRate;
          "pulse.max.frag" = maxQuantumRate;
        };
      };

      jack."99-jack-lowlatency" = {
        "node.latency" = baseQuantumRate;
        "node.quantum" = baseQuantumRate;
      };

      client."99-client-lowlatency" = {
        "stream.properties" = {
          "node.latency" = baseQuantumRate;
          "resample.quality" = 4;
        };
      };
    };

    wireplumber.extraConfig = {
      "99-wireplumber-lowlatency" = {
        "alsa_monitor.rules" = [
          {
            matches = [
              {
                "node.name" = "";
                "apply_properties" = {
                  "audio.format" = "S32LE";
                  "audio.rate" = rate;
                  "api.alsa.period_size" = 2;
                  "api.alsa.disable-batch" = true;
                };
              }
            ];
          }
        ];
      };
    };
  };

  security.pam.loginLimits = [
    {
      domain = "@audio";
      item = "memlock";
      type = "-";
      value = "unlimited";
    }
    {
      domain = "@audio";
      item = "rtprio";
      type = "-";
      value = "99";
    }
  ];

}
