{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.vscode.enable = lib.mkEnableOption "enable vscode";
  };

  config = lib.mkIf config.modules.git.enable {
    home.packages = [
    ];

    programs.vscode = {
      enable = true;

      # Prefer managing versions of things through flakes
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;

      extensions = with pkgs.vscode-extensions; [
        # Web
        astro-build.astro-vscode
        vscode-extensions.ecmel.vscode-html-css
        vscode-extensions.ms-vscode.live-server
        vscode-extensions.yzhang.markdown-all-in-one
        vscode-extensions.davidanson.vscode-markdownlint
        vscode-extensions.bradlc.vscode-tailwindcss

        # Native Debugging
        vscode-extensions.vadimcn.vscode-lldb

        # C/C++
        vscode-extensions.ms-vscode.cpptools
        vscode-extensions.ms-vscode.cmake-tools
        vscode-extensions.twxs.cmake

        # Crab language my beloved :3
        vscode-extensions.rust-lang.rust-analyzer

        # C#
        vscode-extensions.ms-dotnettools.csharp
        vscode-extensions.ms-dotnettools.vscode-dotnet-runtime
        vscode-extensions.ms-dotnettools.csdevkit

        # Python
        vscode-extensions.ms-python.isort
        vscode-extensions.ms-python.vscode-pylance
        vscode-extensions.ms-python.python
        vscode-extensions.ms-python.debugpy

        # Misc
        vscode-extensions.editorconfig.editorconfig
        vscode-extensions.usernamehw.errorlens
        vscode-extensions.tamasfe.even-better-toml
        vscode-extensions.eamodio.gitlens
        vscode-extensions.ms-vscode.hexeditor
        vscode-extensions.esbenp.prettier-vscode

        pkgs.unstable.vscode-extensions.leonardssh.vscord

        # Theming
        vscode-extensions.catppuccin.catppuccin-vsc
        vscode-extensions.catppuccin.catppuccin-vsc-icons
        vscode-extensions.jdinhlife.gruvbox
        vscode-extensions.pkief.material-icon-theme
        vscode-extensions.equinusocio.vsc-material-theme
        vscode-extensions.equinusocio.vsc-material-theme-icons

        # Missing :(
        # neikeq.godot-csharp-vscode
        # jeff-hykin.better-cpp-syntax
        # geequlim.godot-tools
      ];
    };
  };
}
