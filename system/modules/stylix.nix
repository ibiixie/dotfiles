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
      # serif = {
      #   package = pkgs.charis;
      #   name = "Charis";
      # };

      # sansSerif = {
      #   package = pkgs.cooper-hewitt;
      #   name = "Cooper Hewitt";
      # };

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
      size = 48;
    };

    # This doesn't work, not sure why?
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # Catppuccin
    # base16Scheme = {
    #   base00 = "#1e1e2e"; # base
    #   base01 = "#181825"; # mantle
    #   base02 = "#313244"; # surface0
    #   base03 = "#a6adc8"; # "#45475a"; # surface1
    #   base04 = "#9399b2"; # "#585b70"; # surface2
    #   base05 = "#cdd6f4"; # text
    #   base06 = "#f5e0dc"; # rosewater
    #   base07 = "#b4befe"; # lavender
    #   base08 = "#f38ba8"; # red
    #   base09 = "#fab387"; # peach
    #   base0A = "#f9e2af"; # yellow
    #   base0B = "#a6e3a1"; # green
    #   base0C = "#94e2d5"; # teal
    #   base0D = "#89b4fa"; # blue
    #   base0E = "#cba6f7"; # mauve
    #   base0F = "#f2cdcd"; # flamingo
    # };

    # Rosé Pine
    # base16Scheme = {
    #   base00 = "191724";
    #   base01 = "1f1d2e";
    #   base02 = "26233a";
    #   base03 = "6e6a86";
    #   base04 = "908caa";
    #   base05 = "e0def4";
    #   base06 = "e0def4";
    #   base07 = "524f67";
    #   base08 = "eb6f92";
    #   base09 = "f6c177";
    #   base0A = "ebbcba";
    #   base0B = "31748f";
    #   base0C = "9ccfd8";
    #   base0D = "c4a7e7";
    #   base0E = "f6c177";
    #   base0F = "524f67";
    # };

    # Gruvbox Dark
    base16Scheme = {
      base00 = "1d2021"; # ----
      base01 = "3c3836"; # ---
      base02 = "504945"; # --
      base03 = "665c54"; # -
      base04 = "bdae93"; # +
      base05 = "d5c4a1"; # ++
      base06 = "ebdbb2"; # +++
      base07 = "fbf1c7"; # ++++
      base08 = "fb4934"; # red
      base09 = "fe8019"; # orange
      base0A = "fabd2f"; # yellow
      base0B = "b8bb26"; # green
      base0C = "8ec07c"; # aqua/cyan
      base0D = "83a598"; # blue
      base0E = "d3869b"; # purple
      base0F = "d65d0e"; # brown
    };
  };
}
