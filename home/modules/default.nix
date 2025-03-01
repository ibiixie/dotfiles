# Imports user-level modules that should be imported on all of my users.
{
  ...
}:

{
  imports = [
    ./cli
    ./de
    ./gui

    ./sops.nix
  ];
}
