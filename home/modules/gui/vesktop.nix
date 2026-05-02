{
  pkgs,
  ...
}:

{
  # home.packages = [
  #   pkgs.vesktop
  # ];

  programs.vesktop = {
    enable = true;

    settings = {
      minimizeToTray = false;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
    };
  };

  services.arrpc.enable = true;
}
