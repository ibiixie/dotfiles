{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.gammastep = {
    enable = true;

    latitude = 59.334591;
    longitude = 18.063240;
  };
}
