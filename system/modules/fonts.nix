{
  pkgs,
  ...
}:

{
  fonts.enableDefaultPackages = true;

  fonts.packages = [
    pkgs.charis
  ];

  fonts.fontconfig = {
    enable = true;
    antialias = true;
    hinting.enable = true;
    hinting.style = "full";
    # subpixel.lcdfilter = "none";
    subpixel.rgba = "rgb";
  };
}
