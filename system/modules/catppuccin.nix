{
  inputs,
  ...
}:

{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin = {
    enable = true;
    accent = "mauve";
    flavor = "mocha";    
  };
}
