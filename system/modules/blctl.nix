{
  inputs,
  ...
}:

{
  imports = [
    inputs.blctl.nixosModules.default
  ];
}
