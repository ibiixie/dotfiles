{ config, lib, pkgs, ... }:

{
  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/6d/wallhaven-6dqemx.jpg";
      hash = "sha256-lAdWwcKubYlbXZN2xG2ajF6zfe4vdk7zr1TSoSqKyjU=";
    };

    polarity = "dark";

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.agave;
        name = "Agave Nerd Font";
      };

      sizes = {
        terminal = 14;
      };
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
    };

    # Slightly modified Catppuccin Mocha
    base16Scheme = {
      base00 = "1E1E2E";
      base01 = "181825";
      base02 = "313244";
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
      base0D = "CBA6F7"; # ...with more purple :3
      base0E = "CBA6F7";
      base0F = "F2CDCD";
    };
  };
}

