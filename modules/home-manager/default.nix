{ pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    ./git.nix
    ./neovim
    ./zed-editor.nix
  ];
}
