{
  # inputs,
  ...
}:

{
  # imports = [
  #   inputs.noctalia.homeModules.default
  # ];

  xdg.configFile."noctalia/config.toml" = {
    source = ./config.toml;
  };
}
