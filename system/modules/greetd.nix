{
  pkgs,
  ...
}:

{
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
