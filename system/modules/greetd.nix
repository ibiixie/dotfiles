{
  pkgs,
  ...
}:

{
  # Fix issue with systemd-boot output overwriting tuigreet's login screen.
  boot.kernelParams = [ "console=tty1" ];
  services.greetd.vt = 2;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --cmd hyprland";
        user = "greeter";
      };
    };
  };
}
