{
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.vesktop
  ];

  services.arrpc.enable = true;
}
