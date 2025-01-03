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
    ./niri
#    ./zed-editor
    ./firefox
    ./foot
    ./fish
    ./fonts
    ./vscode
    ./flameshot
    ./fuzzel
  ];
}
