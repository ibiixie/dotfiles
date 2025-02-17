# Imports user-level modules that should be imported on all of my users.
{
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
    ./hyfetch.nix
    ./git.nix
    ./ssh.nix
    ./sops.nix
    ./firefox.nix
    ./gammastep.nix
    ./vesktop.nix
  ];
}
