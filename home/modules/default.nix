# Imports user-level modules that should be imported on all of my users.
{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./stylix.nix
    ./foot.nix
    ./fish.nix
    ./helix.nix
    ./nixvim.nix
    ./hyprland.nix
    ./git.nix
    ./ssh.nix
    ./sops.nix
  ];
}
