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

      minQuantum = 256;
      baseQuantum = 256;
      maxQuantum = 256;

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

      # TODO: Change from loopback to combined sink so I can output to both
      # 'easyeffects_sink' and speaker's hardware sink directly to avoid
      # applying my headphone EQ to the speakers.
      extraConfig.pipewire."10-loopbacks" =
        let
          outputSink = "easyeffects_sink";

          mkLoopback =
            {
              name,
              desc,
              extraCaptureProps ? { },
            }:
            {
              name = "libpipewire-module-loopback";
              args = {
                "node.description" = desc;
                "capture.props" = {
                  "node.name" = "loopback.${name}";
                  "media.class" = "Audio/Sink";
                  "audio.position" = [
                    "FL"
                    "FR"
                  ];
                }
                // extraCaptureProps;
                "playback.props" = {
                  "node.name" = "loopback.${name}.out";
                  # "target.object" = outputSink;
                  "node.dont-fallback" = true;
                };
              };
            };
        in
        {
          "context.modules" = [
            (mkLoopback {
              name = "system";
              desc = "System";
              extraCaptureProps = {
                "priority.session" = 2000; # Set as default sink
              };
            })
            (mkLoopback {
              name = "media";
              desc = "Media";
            })
            (mkLoopback {
              name = "comms";
              desc = "Communications";
            })
          ];

          "stream.rules" = [
            {
              matches = [
                { "node.name" = "loopback.system.out"; }
              ];
              actions."update-props" = {
                "target.object" = "easyeffects_sink";
                "node.dont-fallback" = true;
                "node.linger" = true;
              };
            }
            {
              matches = [
                { "node.name" = "loopback.media.out"; }
              ];
              actions."update-props" = {
                "target.object" = "easyeffects_sink";
                "node.dont-fallback" = true;
                "node.linger" = true;
              };
            }
            {
              matches = [
                { "node.name" = "loopback.comms.out"; }
              ];
              actions."update-props" = {
                "target.object" = "easyeffects_sink";
                "node.dont-fallback" = true;
                "node.linger" = true;
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

      extraConfig.pipewire-pulse."20-routing" = {
        "stream.rules" = [
          {
            matches = [
              { "application.name" = "spotify"; }
              { "application.name" = "Firefox"; }
              { "application.name" = "Helium"; }
              { "application.name" = "Vivaldi"; }
            ];
            actions."update-props"."target.object" = "loopback.media";
          }
          {
            matches = [
              { "application.name" = "vesktop"; }
              { "application.name" = "Steam"; }
            ];
            actions."update-props"."target.object" = "loopback.comms";
          }
        ];
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
        # I try to manage most links/targets declaratively
        # and I don't want that to be overwritten by memory.
        "12-goldfish" = {
          "wireplumber.settings" = {
            "node.stream.restore-target" = false;
          };
        };

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
                  "session.suspend-timeout-seconds" = 0;

                  "api.alsa.period-size" = baseQuantum;
                  "api.alsa.period-num" = 4;
                  "api.alsa.headroom" = 0;

                  "api.alsa.disable-batch" = true;
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
