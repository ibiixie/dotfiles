{
  pkgs,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./ags
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
