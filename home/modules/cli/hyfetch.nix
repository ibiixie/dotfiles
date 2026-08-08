{
  ...
}:

{
  programs.hyfetch = {
    enable = true;
    settings = {
      preset = "bisexual";

      backend = "macchina";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.75;
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

  # Enable the backend dependency
  programs.macchina = {
    enable = true;
  };
}
