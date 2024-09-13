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
<<<<<<< Updated upstream

    ./fonts
=======
    ./vscode
>>>>>>> Stashed changes
  ];
}
