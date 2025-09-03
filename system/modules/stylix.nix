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
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrains Mono NL Nerd Font Mono";
      };

      sizes = {
        terminal = 14;
      };
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 32;
    };

    # Slightly modified Cappuccin Mocha
    base16Scheme = {
      base00 = "1E1E2E";
      base01 = "181825";
      # base02 = "313244";
      # base02 = "585B70";
      base02 = "45475A"; # ...with higher contrast!
      base03 = "45475A";
      base04 = "585B70";
      base05 = "CDD6F4";
      base06 = "F5E0DC";
      base07 = "B4BEFE";
      base08 = "F38BA8";
      base09 = "FAB387";
      base0A = "F9E2AF";
      base0B = "A6E3A1";
      base0C = "94E2D5";
      base0D = "CBA6F7"; # ...and more purple :3
      base0E = "CBA6F7";
      base0F = "F2CDCD";
    };
  };
}
