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

  modules.git.enable = true;

  programs.home-manager.enable = true;
}
