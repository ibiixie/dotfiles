{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  # TODO: maybe not the right place for this but bleeeeh :b
  home.pointerCursor = {
    enable = true;
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
    size = 30;
  };

  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";
  };
}
