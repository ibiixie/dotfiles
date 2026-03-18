{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./options.nix
  ];

  home.packages = with pkgs; [
    wl-clipboard-rs
  ];

  services.swww = {
    enable = true;
  };

  wayland.windowManager.jay = {
    enable = true;
  };
}
