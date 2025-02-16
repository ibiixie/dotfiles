{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "rainbow";

      # TODO: The Rust port of hyfetch has a macchina backend so i'll
      #       wait for the release of that to configure this further :D
      backend = "fastfetch";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.8;
      color_align = {
        mode = "horizontal";
        custom_colors = [ ];
        fore_back = null;
      };
      args = null;
      distro = null;
      pride_month_shown = [ ];
      pride_month_disable = false;
    };
  };

  # Enable the backend dependency too.
  programs.fastfetch = {
    enable = true;
  };
}
