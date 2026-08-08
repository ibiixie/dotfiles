# Imports user-level modules that should be imported on all of my users.
{
  ...
}:

{
  imports = [
    ./cli
    ./de
    ./gui

    ./catppuccin.nix

    ./nh.nix

    ./discord-rpc-lsp
  ];
}
