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

      extraConfig.pipewire."10-loopbacks" =
        let
          outputSink = "easyeffects_sink";

          mkNull =
            {
              name,
              desc,
              extraArgs ? { },
            }:
            {
              factory = "adapter";
              args = {
                "factory.name" = "support.null-audio-sink";
                "node.name" = "null.${name}";
                "node.description" = "${desc}";
                "media.class" = "Audio/Sink";
                "audio.position" = "FL,FR";
              }
              // extraArgs;
            };

          mkLoopback =
            {
              name,
              desc,
              extraCaptureProps ? { },
              extraPlaybackProps ? { },
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
                }
                // extraPlaybackProps;
              };
            };

          mkCombine =
            {
              name,
              desc,
              targets ? [ ],
              extraCombineProps ? { },
            }:
            {
              name = "libpipewire-module-combine-stream";
              args = {
                "combine.mode" = "sink";
                "node.name" = "combine.${name}";
                "node.description" = desc;
                "combine.props" = {
                  "audio.position" = [
                    "FL"
                    "FR"
                  ];
                }
                // extraCombineProps;
                "stream.rules" = map (target: {
                  matches = [
                    {
                      "media.class" = "Audio/Sink";
                      "node.name" = target;
                    }
                  ];
                  actions.create-stream = {
                    "node.name" = "combine.${name}-to-${target}.stream";
                  };
                }) targets;
              };
            };
        in
        {
          "context.modules" = [
            (mkCombine {
              name = "system";
              desc = "System Mix";
              targets = [
                "easyeffects_sink"
                "loopback.screenshare-mix"
              ];
              extraCombineProps = {
                "priority.session" = 2000; # Set as default sink
              };
            })
            (mkCombine {
              name = "media";
              desc = "Media Mix";
              targets = [
                "easyeffects_sink"
                "loopback.screenshare-mix"
              ];
            })
            (mkCombine {
              name = "comms";
              desc = "Communications Mix";
              targets = [ "easyeffects_sink" ];
            })
            (mkLoopback {
              name = "screenshare-mix";
              desc = "Screenshare Mix";
              extraPlaybackProps = {
                "application.name" = "Screenshare Mix";
                "application.process.binary" = "screenshare-mix";
                "node.autoconnect" = false;
              };
            })
          ];

          "context.objects" = [
            # (mkNull {
            #   name = "test";
            #   desc = "Test";
            # })
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
              {
                "application.name" = "spotify";
                "media.class" = "Stream/Output/Audio";
              }
              {
                "application.name" = "Firefox";
                "media.class" = "Stream/Output/Audio";
              }
              {
                "application.name" = "Helium";
                "media.class" = "Stream/Output/Audio";
              }
              {
                "application.name" = "Vivaldi";
                "media.class" = "Stream/Output/Audio";
              }
            ];
            actions."update-props"."target.object" = "combine.media";
          }
          {
            matches = [
              {
                "application.name" = "vesktop";
                "media.class" = "Stream/Output/Audio";
              }
              {
                "application.name" = "Steam";
                "media.class" = "Stream/Output/Audio";
              }
            ];
            actions."update-props"."target.object" = "combine.comms";
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
