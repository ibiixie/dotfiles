{ pkgs, lib, inputs, outputs, ... }:

{
  imports = [
    ./git.nix
    ./zed-editor.nix
  ];
}
