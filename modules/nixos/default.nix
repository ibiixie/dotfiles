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
    ./tlp
    ./fish
    ./openssh
    ./nix-ld
    ./nixos-vscode-server
    ./upower

    ./swww

    ./wl-clipboard
    ./grim
    ./slurp

    ./vesktop

    ./obsidian

    ./rust

    ./steam
  ];
}
