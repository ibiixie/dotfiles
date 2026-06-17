{
  pkgs,
  ...
}:

{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "text/html" = "vivaldi-stable.desktop";
      "x-scheme-handler/http" = "vivaldi-stable.desktop";
      "x-scheme-handler/https" = "vivaldi-stable.desktop";
      "x-scheme-handler/about" = "vivaldi-stable.desktop";
      "x-scheme-handler/unknown" = "vivaldi-stable.desktop";
    };
  };

  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.vivaldi}/bin/vivaldi";

  programs.chromium = {
    enable = true;

    package = pkgs.vivaldi;

    extensions = [
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; # uBlock Origin
      }
      {
        id = "nngceckbapebfimnlniiiahkandclblb"; # Bitwarden
      }
      {
        id = "gebbhagfogifgggkldgodflihgfeippi"; # Return YouTUbe Dislike
      }
      {
        id = "hkligngkgcpcolhcnkgccglchdafcnao"; # Web Archives
      }
      {
        id = "ajopnjidmegmdimjlfnijceegpefgped"; # BetterTTV
      }
      {
        id = "fonfeflegdnbhkfefemcgbdokiinjilg"; # ChatReplay
      }
    ];

    dictionaries = [
      pkgs.hunspellDictsChromium.en_US
      pkgs.hunspellDictsChromium.sv_SE
    ];
  };
}
