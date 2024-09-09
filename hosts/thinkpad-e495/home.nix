{ config, pkgs, inputs, outputs, ... }:

{
  home.username = "biixie";
  home.homeDirectory = "/home/biixie";
  home.stateVersion = "24.05";

  home.packages = [

  ];

  home.file = {

  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  modules.git = {
    enable = true;

    userName = "imxela";
    userEmail = "65206220+imxela@users.noreply.github.com";
  };

  modules.neovim.enable = true;
  modules.hyprland.enable = true;
  modules.zed-editor.enable = true;

  programs.home-manager.enable = true;
}
