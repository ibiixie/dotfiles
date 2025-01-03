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

    niri.enable = true;

    hyprland = {
      enable = false;

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

    # Does not work on Hyprland qwq
    # flameshot.enable = true;
    
    # Cannot compile it because the build process results pagefiling :c
    # zed-editor.enable = true;
    
    foot = {
      enable = true;

      font = "iosevka";
      fontSize = 8;
      
      pad = {
        x = 10;
	y = 10;
      };
    };

    vscode.enable = true;

    ags.enable = true;
    fuzzel.enable = true;
  };

  programs.home-manager.enable = true;
}
