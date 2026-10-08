{
  pkgs,
  ...
}:

{
  # Persist audio settings and volumes across reboot...
  environment.etc."alsa/asound.state".source = ./asound.state;

  # ... by running alsactl store once the sound card is loaded
  services.udev.extraRules = ''
    SUBSYSTEM=="sound", ACTION=="change", KERNEL=="card0", RUN+="${pkgs.alsa-utils}/bin/alsactl restore --file /etc/alsa/asound.state"
  '';

  # Low-latency audio configuration
  services.pipewire =
    let
      mkQuantumRate = quantum: rate: "${toString quantum}/${toString rate}";

      # NOTE: These values are only stable with the SCX Flash scheduler.
      # NOTE: Measured round-trip latency is 6 ms @ 64 quant and 48kHz
      #       including EasyEffects processing and default period size/headroom.
      minQuantum = 64;
      baseQuantum = 64;
      maxQuantum = 64;
      rate = 48000;

      baseQuantumRate = mkQuantumRate baseQuantum rate;
      minQuantumRate = mkQuantumRate minQuantum rate;
      maxQuantumRate = mkQuantumRate maxQuantum rate;
    in
    {
      extraConfig.pipewire."99-pipewire-lowlatency" = {
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

      extraConfig.pipewire-pulse."99-pulse-lowlatency" = {
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

      extraConfig.jack."99-jack-lowlatency" = {
        # "node.latency" = baseQuantumRate;
        # "node.quantum" = baseQuantumRate;
      };

      extraConfig.client."99-client-lowlatency" = {
        "stream.properties" = {
          # "node.latency" = baseQuantumRate;
          "resample.quality" = 4;
        };
      };

      wireplumber.extraConfig = {
        "99-wireplumber-lowlatency" = {
          "monitor.alsa.rules" = [
            {
              matches = [
                {
                  "device.name" = "~alsa_card.*";
                }
              ];
              actions = {
                "update-props" = {
                  "api.alsa.use-ucm" = false;
                };
              };
            }
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
                  # NOTE
                  # Clicking audio at low latency and period-num.
                  # Fairly bad at 64 quantum and 2 period-num.
                  # Better at 64 quantum and 4 period-num.
                  # TODO: Try commenting out this and checking latency. (64 qaunt @ 48kHz = ~6.5 ms)
                  # TODO: Try setting to 8 and checking for clicks + measure latency.
                  # "api.alsa.period-num" = 4;
                  # "api.alsa.headroom" = 0;
                  # "api.alsa.disable-batch" = true;
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
