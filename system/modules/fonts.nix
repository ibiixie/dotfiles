{
  pkgs,
  ...
}:

{
  fonts.enableDefaultPackages = true;

  fonts.packages = [
    pkgs.charis
    pkgs.maple-mono.NormalNL-NF-unhinted
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
