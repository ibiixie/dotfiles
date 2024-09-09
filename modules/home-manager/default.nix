{ pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    ./git.nix
    ./neovim
    ./hyprland
    ./zed-editor.nix
  ];
}
