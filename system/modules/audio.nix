{
  ...
}:

let
  mkQuantumRate = quantum: rate: "${toString quantum}/${toString rate}";

  minQuantum = 256;
  baseQuantum = 256;
  maxQuantum = 256;
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

          "mem.allow-mlock" = true;
          "mem.warn-mlock" = false;

          "default.clock.allowed-rates" = [
            48000
          ];
        };

        "context.modules" = [
          {
            name = "libpipewire-module-rt";
            flags = [
              "ifexists"
              "nofail"
            ];
            args = {
              "nice.level" = -15;
              "rt.prio" = 75;
              "rt.time.soft" = 200000;
              "rt.time.hard" = 200000;
            };
          }
        ];
      };

      pipewire-pulse."99-pulse-lowlatency" = {
        "context.modules" = [
          {
            name = "libpipewire-module-rt";
            flags = [
              "ifexists"
              "nofail"
            ];
            args = {
              "nice.level" = -15;
              "rt.prio" = 75;
              "rt.time.soft" = 200000;
              "rt.time.hard" = 200000;
              "rtkit.enabled" = false;
              "rtportal.enabled" = false;
            };
          }
        ];
        "pulse.properties" = {
          "server.address" = [ "unix:native" ];

          "pulse.min.req" = minQuantumRate;
          "pulse.default.req" = baseQuantumRate;

          "pulse.min.frag" = minQuantumRate;
          "pulse.default.frag" = baseQuantumRate;

          "pulse.default.tlength" = baseQuantumRate;

          "pulse.min.quantum" = minQuantumRate;
        };
      };

      jack."99-jack-lowlatency" = {
        # "node.latency" = baseQuantumRate;
        # "node.quantum" = baseQuantumRate;
      };

      client."99-client-lowlatency" = {
        "stream.properties" = {
          # "node.latency" = baseQuantumRate;
          "resample.quality" = 4;
        };
      };
    };

    wireplumber.extraConfig = {
      "99-wireplumber-lowlatency" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                "node.name" = "~alsa_output.*";
              }
              {
                "node.name" = "~alsa_input.*";
              }
            ];
            actions = {
              "update-props" = {
                "audio.format" = "S32LE";
                "audio.rate" = rate;
                "node.pause-on-idle" = false;

                "api.alsa.period-size" = baseQuantum;
                "api.alsa.period-num" = 2;
                "api.alsa.headroom" = 0;
                "api.alsa.disable-batch" = true;
                "api.alsa.use-ucm" = false;
              };
            };
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
      value = "75";
    }
    {
      domain = "@audio";
      item = "nice";
      type = "-";
      value = "-15";
    }
  ];
}
