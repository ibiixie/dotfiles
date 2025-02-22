{
  ...
}:

{
  programs.helix = {
    enable = true;

    defaultEditor = true;

    settings = {
      editor = {
        scrolloff = 10;
        line-number = "relative";
        cursorline = true;
        shell = [ "fish -c" ];
        rulers = [ 80 ];
        bufferline = "always";

        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "hint";
        };

        end-of-line-diagnostics = "hint";

        cursor-shape = {
          normal = "underline";
          insert = "bar";
          select = "block";
        };

        file-picker = {
          hidden = false;
        };

        indent-guides = {
          render = true;
        };
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
            args = [ ];
          };
        }

        {
          name = "yaml";
          auto-format = true;
          formatter = {
            command = "prettier";
            args = [
              "--parser"
              "yaml"
            ];
          };
        }
      ];
    };
  };
}
