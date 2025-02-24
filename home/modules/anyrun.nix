{
  config,
  inputs,
  pkgs,
  ...
}:

{
  programs.anyrun = {
    enable = true;

    config = {
      x.fraction = 0.5;
      y.fraction = 0.3;
      width.fraction = 0.3;
      hideIcons = false;
      ignoreExclusiveZones = false;
      layer = "overlay";
      hidePluginInfo = true; # true;
      closeOnClick = false;
      showResultsImmediately = true;
      maxEntries = 10;

      plugins = with inputs.anyrun.packages.${pkgs.system}; [
        applications
        rink
        symbols
        shell
      ];
    };

    extraConfigFiles."applications.ron".text = # ron
      ''
        Config(
          desktop_actions: false;
          max_entries: 5,
        )
      '';

    extraConfigFiles."symbols.ron".text = # ron
      ''
        Config(
          prefix: ":sym",
          symbols: {
            "shrug": "¯\\_(ツ)_/¯",
          },
          max_entries: 3,
        )
      '';

    extraConfigFiles."shell.ron".text = # ron
      ''
        Config(
          prefix: ":sh",
          shell: "fish",
        )
      '';

    extraCss =
      let
        colorScheme = with config.stylix.base16Scheme; {
          background = base00;
          accent = base0E;
          text = base05;
        };
      in
      # css
      ''
        * {
          all: unset;
        }

        #entry {
          background-color: #${colorScheme.background};
          padding: 8px;

          margin-bottom: 16px;

          border-radius: 8px;
          border: 2px solid #${colorScheme.accent};
        }

        #window {
          background-color: rgba(0, 0, 0, 0.3);

          color: #${colorScheme.text};
          font-family: sans-serif;
          font-size: 1.2rem;
        }

        #main {
          background-color: transparent;
          border-radius: 8px;
          padding: 0px 8px;
        }

        #match {
          padding: 2px;
        }

        #match:selected {
          background-color: #${colorScheme.accent};
          color: #${colorScheme.background};
          border-radius: 8px;
        }

        #plugin {
          background-color: #${colorScheme.background};
          border-radius: 8px;

          margin: 4px;
        }
      '';
  };
}
