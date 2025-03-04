{
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.obs-cmd
  ];

  programs.obs-studio = {
    enable = true;
  };
}
