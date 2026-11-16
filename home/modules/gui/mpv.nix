{
  pkgs,
  ...
}:

{
  programs.mpv = {
    enable = true;

    config = {
      vo = "gpu-next";
      hwdec = "auto-safe";
      profile = "high-quality";
      volume = 70;

      target-colorspace-hint = "auto";
    };

    scripts = with pkgs; [
      mpvScripts.modernz
      mpvScripts.quack
    ];

    scriptOpts = {
      modernz = {
        layout = "mini";
        icon_theme = "fluent";
        icon_style = "mixed";
      };
    };
  };
}
