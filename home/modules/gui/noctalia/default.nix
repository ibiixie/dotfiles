{
  # inputs,
  config,
  ...
}:

{
  xdg.configFile."noctalia/config.toml" = {
    source = ./config.toml;
  };

  xdg.desktopEntries.manage-screencast-audio = {
    name = "Screencast: Manage Audio";
    exec = "${config.xdg.configHome}/scripts/noctalia/manage-screencast-audio.sh";
  };

  xdg.configFile."scripts/noctalia/manage-screencast-audio.sh" = {
    source = ./scripts/manage-screencast-audio.sh;
    executable = true;
  };
}
