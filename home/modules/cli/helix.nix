{
  pkgs,
  ...
}:

let
  typescript = pkgs.typescript;
in
{
  # Use a dedicated theme for Helix because the Stylix one is not great.
  stylix.targets.helix.enable = false;

  programs.helix = {
    enable = true;

    defaultEditor = true;

    settings = {
      theme = "catppuccin_mocha";
      editor = {
        mouse = false;
        scrolloff = 10;
        line-number = "relative";
        cursorline = true;
        shell = [ "fish -c" ];
        true-color = true;
        color-modes = true;

        rulers = [
          80
          120
        ];

        bufferline = "always";

        inline-diagnostics = {
          cursor-line = "hint";
          other-lines = "disable";
        };

        end-of-line-diagnostics = "hint";

        cursor-shape = {
          normal = "underline";

          # Bar causes cursor to become invisible when using indent guides
          # so I'm switching to a block instead for now.
          # insert = "bar";

          insert = "block";
          select = "block";
        };

        file-picker = {
          hidden = false;
        };

        indent-guides = {
          render = true;
          character = "╎";
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "diagnostics"
            "version-control"
          ];
          center = [
            "file-name"
          ];
          right = [
            "position"
            "total-line-numbers"
          ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        lsp = {
          # auto-signature-help = false;
          display-messages = true;
        };
      };

      keys = {
        normal = {
          # j = "move_char_left";
          # k = "move_visual_line_up";
          # l = "move_visual_line_down";
          # "ö" = "move_char_right";
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

        {
          name = "rust";
          auto-format = true;
        }

        {
          name = "toml";
          auto-format = true;
        }

        {
          name = "dockerfile";
          auto-format = true;
        }

        {
          name = "docker-compose";
          auto-format = true;
        }

        {
          name = "json";
          auto-format = true;
        }

        {
          name = "jsonc";
          auto-format = true;
        }

        {
          name = "javascript";
          auto-format = true;
        }

        {
          name = "jsx";
          auto-format = true;
        }

        {
          name = "gjs";
          auto-format = true;
        }

        {
          name = "typescript";
          auto-format = true;
        }

        {
          name = "tsx";
          auto-format = true;
        }

        {
          name = "css";
          auto-format = true;
        }

        {
          name = "scss";
          auto-format = true;
        }

        {
          name = "html";
          auto-format = true;
          scope = "source.html";
          roots = [ ];
          file-types = [ "html" ];
          language-servers = [ "superhtml-lsp" ];
        }

        {
          name = "gts";
          auto-format = true;
        }

        {
          name = "svelte";
          auto-format = true;
        }

        {
          name = "astro";
          auto-format = true;
          language-servers = [ "astro-ls" ];
          # formatter = {
          #   command = "prettier";
          #   args = [
          #     "--plugin"
          #     "prettier-plugin-astro"
          #     "--parser"
          #     "astro"
          #   ];
          # };
        }
      ];
      language-server.rust-analyzer.config.check = {
        command = "clippy";
        # make clippy yell at me lots :D
        extraArgs = [
          "--"
          "-W"
          "clippy::unwrap_used"
          "-W"
          "clippy::expect_used"
          "-W"
          "clippy::pedantic"
          "-W"
          "clippy::nursery"
        ];
      };
      language-server.astro-ls = {
        command = "astro-ls";
        args = [ "--stdio" ];
        config = {
          typescript = {
            tsdk = "${typescript}/lib/node_modules/typescript/lib";
          };
        };
      };
      language-server.superhtml-lsp = {
        command = "superhtml";
        args = [ "lsp" ];
      };
    };
  };
}
