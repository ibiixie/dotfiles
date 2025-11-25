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
        scrolloff = 5;
        line-number = "relative";
        cursorline = true;
        shell = [
          "fish"
          "-c"
        ];
        true-color = true;
        color-modes = true;

        rulers = [
          80
          120
        ];

        soft-wrap = {
          enable = true;
        };

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
          display-inlay-hints = true;
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
          language-servers = [ "discord-rpc" ];
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
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "rust";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "toml";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "dockerfile";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "docker-compose";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "json";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "jsonc";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "javascript";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "jsx";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "gjs";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "typescript";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "tsx";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "css";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "scss";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "html";
          auto-format = true;
          scope = "source.html";
          roots = [ ];
          file-types = [ "html" ];
          language-servers = [ "superhtml-lsp" "discord-rpc" ];
        }

        {
          name = "gts";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "svelte";
          auto-format = true;
          language-servers = [ "discord-rpc" ];
        }

        {
          name = "astro";
          auto-format = true;
          language-servers = [ "astro-ls" "discord-rpc" ];
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
      language-server.discord-rpc = {
        command = "discord-rpc-lsp";
      };
    };
  };
}
