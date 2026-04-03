{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  stylix.targets.spicetify.enable = false;

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
        wikify
        songStats
        history
        beautifulLyrics
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";
    };
}
