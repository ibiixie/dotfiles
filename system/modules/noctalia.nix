{
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.noctalia.nixosModules.default
  ];

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  services.power-profiles-daemon.enable = lib.mkForce false;
}
