# Imports user-level modules that should be imported on all of my users.
{ config, lib, pkgs, ... }:

{
  imports = [
    ./stylix.nix
    ./nixvim.nix
  ];
}
