{
  inputs,
  ...
}:

{
  home.packages = [
    inputs.discord-rpc-lsp.packages.x86_64-linux.default
  ];

  home.file.".discord-rpc-lsp/config.toml".source = ./config.toml;
}
