{
  pkgs,
  ...
}:

{
  # Persist audio settings and volumes across reboot.
  environment.etc."alsa/asound.state".source = ./asound.state;

  # By running alsactl store once the sound card is loaded
  services.udev.extraRules = ''
    SUBSYSTEM=="sound", ACTION=="change", KERNEL=="card0", RUN+="${pkgs.alsa-utils}/bin/alsactl restore --file /etc/alsa/asound.state"
  '';
}
