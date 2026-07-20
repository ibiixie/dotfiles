{
  inputs,
  ...
}:

{
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  qt.enable = true;

  home.packages = [
    inputs.qml-niri.packages.x86_64-linux.default
  ];

  xdg.configFile."quickshell/shell.qml" = {
    source = ./shell.qml;

    # Hot-reload
    # onChange = ''
    #   pkill quickshell && quickshell -d
    # '';
  };

  xdg.configFile."quickshell/scripts/weather.sh" = {
    source = ./scripts/weather.sh;
  };
}
