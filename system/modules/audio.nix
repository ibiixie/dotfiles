{
  inputs,
  ...
}:

let
  # Notes to self :3
  # Latency formula: (quantumRate / Hz) x 1000
  # Tested on Intel Core i5-13600K.
  # TODO: Check distortion with gamemode w/ a rate of 384.
  #   Audible distortion still when using gamemode
  #   but only during prolonged sessions?
  # ADDENDUM: Enabled rtkit for real-time audio, might fix issues.
  #           Might be able to lower the latency further as a result?
  quantumRate = 384;
in
{
  # services = {
  #   pipewire = {
  #     enable = true;
  #     alsa.enable = true;
  #     alsa.support32Bit = true;
  #     pulse.enable = true;
  #     jack.enable = true;

  #     # Attempt to fix crackling audio issue
  #     extraConfig.pipewire = {
  #       "98-cracklingfix" = {
  #         "context.properties" = {
  #           "default.clock.allowed-rates" = [
  #             44100 # Added to fix a crackling audio issue!
  #             48000
  #           ];
  #         };
  #       };

  #       "99-lowlatency" = {
  #         "context.properties" = {
  #           "default.clock.rate" = 48000;
  #           "default.clock.quantum" = quantumRate;
  #           "default.clock.min-quantum" = quantumRateMin;
  #           "default.clock.max-quantum" = quantumRateMax;
  #         };
  #         "context.modules" = [
  #           {
  #             name = "libpipewire-module-rt";
  #             flags = [
  #               "ifexists"
  #               "nofail"
  #             ];
  #             args = {
  #               "nice.level" = -15;
  #               "rt.prio" = 88;
  #               "rt.time.soft" = 200000;
  #               "rt.time.hard" = 200000;
  #             };
  #           }
  #         ];
  #       };
  #     };

  #     extraConfig.pipewire-pulse = {
  #       "99-lowlatency" = {
  #         "pulse.properties" = {
  #           "server.address" = [ "unix:native" ];
  #           "pulse.min.req" = "${toString quantumRateMin}/48000";
  #           "pulse.default.req" = "${toString quantumRate}/48000";
  #           "pulse.max.req" = "${toString quantumRateMax}/48000";
  #           "pulse.min.quantum" = "${toString quantumRateMin}/48000";
  #           "pulse.max.quantum" = "${toString quantumRateMax}/48000";
  #         };
  #         "stream.properties" = {
  #           "node.latency" = "${toString quantumRate}/48000";
  #           "resample.quality" = 1;
  #         };
  #       };
  #     };

  #     extraConfig.client = {
  #       "99-lowlatency" = {
  #         "stream.properties" = {
  #           "node.latency" = quantumRate;
  #           "resample.quality" = 1;
  #         };
  #       };
  #     };

  #     extraConfig.wireplumber = {
  #       enable = true;
  #       extraConfig = {
  #         "99-alsa-lowlatency" = {
  #           "monitor.alsa.rules" = [
  #             {
  #               matches = [ { "node.name" = "alsa_output.*"; } ];
  #               actions.update-props = {
  #                 "audio.format" = "S32LE";
  #                 "audio.rate" = "48000";
  #               };
  #             }
  #           ];
  #         };
  #       };
  #     };
  #   };
  # };

  # services.pipewire = {
  #   enable = true;

  #   extraConfig = {
  #     pipewire."99-lowlatency" = {
  #       "context.properties"."default.clock.min-quantum" = quantumRate;

  #       "context.modules" = [
  #         {
  #           name = "libpipewire-module-rt";
  #           flags = [
  #             "ifexists"
  #             "nofail"
  #           ];
  #           args = {
  #             "nice.level" = -15;
  #             "rt.prio" = 88;
  #             "rt.time.soft" = 200000;
  #             "rt.time.hard" = 200000;
  #           };
  #         }
  #       ];
  #     };

  #     pipewire-pulse."99-lowlatency"."pulse.properties" = {
  #       "server.address" = [ "unix:native" ];
  #       "pulse.min.req" = "${toString quantumRate}/48000";
  #       "pulse.min.quantum" = "${toString quantumRate}/48000";
  #       "pulse.min.frag" = "${toString quantumRate}/48000";
  #     };

  #     client."99-lowlatency"."stream.properties" = {
  #       "node.latency" = "${toString quantumRate}/48000";
  #       "resample.quality" = 1;
  #     };
  #   };

  #   wireplumber = {
  #     enable = true;
  #     extraConfig = {
  #       "99-alsa-lowlatency"."monitor.alsa.rules" = [
  #         {
  #           matches = [ { "node.name" = "~alsa_output.*"; } ];
  #           actions.update-props = {
  #             "audio.format" = "S32LE";
  #             "audio.rate" = 48000;
  #           };
  #         }
  #       ];
  #     };
  #   };
  # };

  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    lowLatency = {
      enable = true;
      quantum = 384; # TODO: Test lower values
      rate = 48000;
    };
  };
}
