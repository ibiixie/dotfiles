{
  pkgs,
  ...
}:

{
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
