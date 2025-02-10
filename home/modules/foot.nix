{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.foot = {
    enable = true;

    settings = {
      main = {
        pad = "8x8";
      };

      cursor = {
        style = "beam";
      };
    };
  };
}
