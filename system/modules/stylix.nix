{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  wallpaper01 = {
    url = "https://w.wallhaven.cc/full/5w/wallhaven-5we787.jpg";
    hash = "sha256-SZnRkJlP7PTPWqcIfZE03dC/qz87LscyAnhIEDHUqcs=";
  };

  wallpaper02 = {
    url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/refs/heads/master/flower-field.jpg";
    hash = "sha256-R5TUkhj8kl4+7OR4P7LK9hItRRw/gvKUbTCvo9LNOII=";
  };

  wallpaper03 = {
    url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/refs/heads/master/car-2.png";
    hash = "sha256-V7vrAggKhuHJd9D9tD7WsS+UOHYT17pryOmMRrratoo=";
  };

  wallpaper04 = {
    url = "https://raw.githubusercontent.com/orangci/walls-catppuccin-mocha/refs/heads/master/pink-clouds.jpg";
    hash = "sha256-RQD/8RsBoNmZB+6SGqap3Q7OYnk9xXNy6bjFplUoijQ=";
  };

  wallpaper05 = {
    url = "https://w.wallhaven.cc/full/gp/wallhaven-gpl8d3.jpg";
    hash = "sha256-t5f3VOHHZcaiGasyTyFh8eL87c0mq2FCsPVNNj20gqg=";
  };

  wallpaper = wallpaper01;
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      url = wallpaper.url;
      hash = wallpaper.hash;
    };

    polarity = "dark";

    fonts = {
      serif = {
        package = pkgs.charis;
        name = "Charis";
      };

      sansSerif = {
        package = pkgs.cooper-hewitt;
        name = "Cooper Hewitt";
      };

      monospace = {
        # package = pkgs.nerd-fonts.jetbrains-mono;
        # name = "JetBrains Mono NL Nerd Font Mono";
        package = pkgs.maple-mono.NormalNL-NF-unhinted;
        name = "Maple Mono Normal NL NF";
      };

      sizes = {
        terminal = 13;
      };
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 32;
    };

    # This doesn't work, not sure why?
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    base16Scheme = {
      base00 = "#1e1e2e"; # base
      base01 = "#181825"; # mantle
      base02 = "#313244"; # surface0
      base03 = "#45475a"; # surface1
      base04 = "#585b70"; # surface2
      base05 = "#cdd6f4"; # text
      base06 = "#f5e0dc"; # rosewater
      base07 = "#b4befe"; # lavender
      base08 = "#f38ba8"; # red
      base09 = "#fab387"; # peach
      base0A = "#f9e2af"; # yellow
      base0B = "#a6e3a1"; # green
      base0C = "#94e2d5"; # teal
      base0D = "#89b4fa"; # blue
      base0E = "#cba6f7"; # mauve
      base0F = "#f2cdcd"; # flamingo
    };
  };
}
