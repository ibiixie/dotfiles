{
  ...
}:

{
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };

  qt.enable = true;

  xdg.configFile."quickshell/shell.qml" = {
    source = ./shell.qml;

    # Hot-reload
    # onChange = ''
    #   pkill quickshell && quickshell -d
    # '';
  };
}
