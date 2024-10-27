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

    ./wl-clipboard
    ./grim
    ./slurp

    ./vesktop

    ./obsidian

    ./rust
  ];
}
