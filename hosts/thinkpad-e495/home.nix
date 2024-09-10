{ config, pkgs, inputs, outputs, ... }:

{
  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config.allowUnfree = true;
  };

  home.username = "biixie";
  home.homeDirectory = "/home/biixie";
  home.stateVersion = "24.05";

  home.packages = [

  ];

  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  modules = {
    git = {
      enable = true;

      userName = "imxela";
      userEmail = "65206220+imxela@users.noreply.github.com";
    };

    neovim.enable = true;
    hyprland.enable = true;
    zed-editor.enable = true;
    foot.enable = true;
  };

  programs.home-manager.enable = true;
}
