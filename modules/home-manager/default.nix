{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./git
    ./neovim
    ./hyprland
    ./zed-editor
    ./firefox
    ./foot
    ./fish
    ./fonts
    ./vscode
    ./flameshot
  ];
}
