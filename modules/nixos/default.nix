{ pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    ./hyprland
    ./firefox
  ];
}
