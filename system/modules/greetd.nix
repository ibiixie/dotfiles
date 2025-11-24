{
  pkgs,
  ...
}:

{
  # Fix issue with systemd-boot output overwriting tuigreet's login screen.
  # boot.kernelParams = [ "console=tty1" ];

  services.greetd = {
    enable = true;
    useTextGreeter = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks --remember --remember-session --power-shutdown 'sudo systemctl poweroff' --power-reboot 'sudo systemctl reboot'";
        user = "greeter";
      };
    };
  };
}
