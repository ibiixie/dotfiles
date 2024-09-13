{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
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
    fish.enable = true;
    neovim.enable = true;

    git = {
      enable = true;

      userName = "imxela";
      userEmail = "65206220+imxela@users.noreply.github.com";
    };

    hyprland = {
      enable = true;

      input.sensitivity = -0.20;
      input.acceleration = true;
    
      monitors = [
        "eDP-1, preferred, auto, 1"
      ];
    };

    fonts = {
      enable = true;

      iosevka.enable = true;

      defaults = {
        monospace = [ "iosevka" ];
      };
    };
    
    zed-editor.enable = true;
    
    foot = {
      enable = true;

      font = "iosevka";
      fontSize = 8;
    };
  };

  programs.home-manager.enable = true;
}
