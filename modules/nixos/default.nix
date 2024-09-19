{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./hyprland
    ./firefox
    ./pipewire
    ./fish
    ./openssh
    ./nix-ld
  ];
}
