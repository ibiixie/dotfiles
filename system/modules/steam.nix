{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];

  environment.systemPackages = [
    pkgs.mangohud
    pkgs.osu-lazer # Should probably move this to another module
  ];

  programs = {
    gamemode.enable = true;
    gamescope = {
      enable = true;
      # capSysNice = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;

      platformOptimizations.enable = true;

      package = pkgs.steam.override {
        extraPkgs =
          pkgs': with pkgs'; [
            libXcursor
            libXi
            libXinerama
            libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib # Provides libstdc++.so.6
            libkrb5
            keyutils
            # Add other libraries as needed
          ];
      };

      extraCompatPackages = [
        pkgs.proton-ge-bin
      ];

      gamescopeSession.enable = true;
    };
  };
}
