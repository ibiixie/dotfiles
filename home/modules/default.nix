# Imports user-level modules that should be imported on all of my users.
{ config, lib, pkgs, ... }:

{
  imports = [
    ./stylix.nix
    ./fish.nix
    ./nixvim.nix
    ./hyprland.nix
    ./git.nix
    ./sops.nix
  ];
}
