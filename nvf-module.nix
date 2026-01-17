{
  inputs,
  pkgs,
  lib,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;

    settings.vim = {
      # =====================
      # Basic Settings
      # =====================
      viAlias = false;
      vimAlias = false;
      preventJunkFiles = true;

      # Line numbers
      lineNumberMode = "relNumber";

      # Search
      searchCase = "smart";
      hideSearchHighlight = true;

      # Globals
      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      # Options
      options = {
        tabstop = 4;
        shiftwidth = 4;
        autoindent = true;
        termguicolors = true;
        signcolumn = "yes";
        mouse = "a";
        wrap = false;
        cmdheight = 1;
        updatetime = 250;
        tm = 300; # timeoutlen
        splitright = true;
        splitbelow = true;
      };

      # =====================
      # Theme
      # =====================
      theme = {
        enable = true;
        name = "catppuccin";
        style = "frappe";
      };

      visuals = {
        tiny-devicons-auto-colors.enable = true;
        indent-blankline = {
          enable = true;

          setupOpts = {
            debounce = 100;

            indent = {
              char = "│";
              tab_char = "▏";
              smart_indent_cap = true;
              repeat_linebreak = true;
              priority = 1;
              highlight = [
                "IblIndent"
              ];
            };

            scope = {
              enabled = true;
              char = "┃";
              show_start = false;
              show_end = false;
              highlight = [
                "IblScope"
              ];
              priority = 1024;

              exclude = {
                language = ["help" "dashboard" "alpha"];
                node_type = {
                  "*" = ["source_file" "program"];
                  lua = ["chunk"];
                  python = ["module"];
                };
              };
            };

            whitespace = {
              remove_blankline_trail = true;
            };

            viewport_buffer = {
              min = 30;
              max = 300;
            };
          };
        };
      };

      # =====================
      # LSP
      # =====================
      lsp = {
        enable = true;
        formatOnSave = true;
      };

      # =====================
      # Languages
      # =====================
      languages = {
        enableTreesitter = true;
        enableFormat = true;

        nix.enable = true;
        rust = {
          enable = true;
          extensions.crates-nvim.enable = true;
        };
        go.enable = true;
        python.enable = true;
        ts.enable = true;
        html = {
          enable = true;
          treesitter = {
            enable = true;
            autotagHtml = true;
          };
        };
        css.enable = true;
        clang.enable = true;
        markdown.enable = true;
        yaml.enable = true;
        sql.enable = true;
        bash.enable = true;
        lua.enable = true;
      };

      # =====================
      # Autocomplete
      # =====================
      autocomplete.nvim-cmp = {
        enable = true;
        mappings = {
          confirm = "<CR>";
          complete = "<C-Space>";
          scrollDocsUp = "<C-b>";
          scrollDocsDown = "<C-f>";
          close = "<C-e>";
        };
      };

      # =====================
      # UI Components
      # =====================
      statusline.lualine = {
        enable = true;
        theme = "gruvbox";
      };

      tabline.nvimBufferline.enable = true;

      filetree.neo-tree = {
        enable = true;
        setupOpts = {
          close_if_last_window = true;
        };
      };

      telescope.enable = true;

      ui = {
        illuminate.enable = true;
        colorizer.enable = true;
        noice.enable = true;
      };

      # =====================
      # Git
      # =====================
      git = {
        enable = true;
        gitsigns = {
          enable = true;
          setupOpts.current_line_blame = true;
        };
      };

      # =====================
      # Utility
      # =====================
      autopairs.nvim-autopairs.enable = true;
      comments.comment-nvim.enable = true;
      binds.whichKey.enable = true;

      # =====================
      # Keymaps
      # =====================
      keymaps = [
        # File explorer
        {
          mode = "n";
          key = "<leader>e";
          action = "<cmd>Neotree toggle<CR>";
          desc = "Toggle explorer";
        }

        # Window navigation
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w>h";
          desc = "Move left";
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w>j";
          desc = "Move down";
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w>k";
          desc = "Move up";
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w>l";
          desc = "Move right";
        }

        # Clear search highlight
        {
          mode = "n";
          key = "<leader>h";
          action = "<cmd>nohlsearch<CR>";
          desc = "Clear highlights";
        }

        # Buffer navigation
        {
          mode = "n";
          key = "<A-,>";
          action = "<cmd>BufferLineCyclePrev<CR>";
          desc = "Prev buffer";
        }
        {
          mode = "n";
          key = "<A-.>";
          action = "<cmd>BufferLineCycleNext<CR>";
          desc = "Next buffer";
        }
        {
          mode = "n";
          key = "<A-c>";
          action = "<cmd>bdelete<CR>";
          desc = "Close buffer";
        }

        # Telescope
        {
          mode = "n";
          key = "<leader>ff";
          action = "<cmd>Telescope find_files<CR>";
          desc = "Find files";
        }
        {
          mode = "n";
          key = "<leader>fg";
          action = "<cmd>Telescope live_grep<CR>";
          desc = "Live grep";
        }
        {
          mode = "n";
          key = "<leader>fb";
          action = "<cmd>Telescope buffers<CR>";
          desc = "Buffers";
        }
        {
          mode = "n";
          key = "<leader>fh";
          action = "<cmd>Telescope help_tags<CR>";
          desc = "Help";
        }

        # LSP
        {
          mode = "n";
          key = "gd";
          action = "<cmd>lua vim.lsp.buf.definition()<CR>";
          desc = "Go to definition";
        }
        {
          mode = "n";
          key = "K";
          action = "<cmd>lua vim.lsp.buf.hover()<CR>";
          desc = "Hover";
        }
        {
          mode = "n";
          key = "<leader>ca";
          action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
          desc = "Code action";
        }
        {
          mode = "n";
          key = "<leader>rn";
          action = "<cmd>lua vim.lsp.buf.rename()<CR>";
          desc = "Rename";
        }
        {
          mode = "n";
          key = "gr";
          action = "<cmd>Telescope lsp_references<CR>";
          desc = "References";
        }

        # Git
        {
          mode = "n";
          key = "<leader>hs";
          action = "<cmd>Gitsigns stage_hunk<CR>";
          desc = "Stage hunk";
        }
        {
          mode = "n";
          key = "<leader>hr";
          action = "<cmd>Gitsigns reset_hunk<CR>";
          desc = "Reset hunk";
        }
        {
          mode = "n";
          key = "<leader>hb";
          action = "<cmd>Gitsigns blame_line<CR>";
          desc = "Blame";
        }
        {
          mode = "n";
          key = "]c";
          action = "<cmd>Gitsigns next_hunk<CR>";
          desc = "Next hunk";
        }
        {
          mode = "n";
          key = "[c";
          action = "<cmd>Gitsigns prev_hunk<CR>";
          desc = "Prev hunk";
        }

        # Save
        {
          mode = "n";
          key = "<C-s>";
          action = "<cmd>w<CR>";
          desc = "Save";
        }
        {
          mode = "i";
          key = "<C-s>";
          action = "<Esc><cmd>w<CR>";
          desc = "Save";
        }

        # Keep indent in visual mode
        {
          mode = "v";
          key = "<";
          action = "<gv";
          desc = "Indent left";
        }
        {
          mode = "v";
          key = ">";
          action = ">gv";
          desc = "Indent right";
        }
      ];
      # =====================
      # Extra Plugins
      # =====================
      extraPlugins = {
        alpha = {
          package = pkgs.vimPlugins.alpha-nvim;
          setup = ''
            local alpha = require("alpha")
            local dashboard = require("alpha.themes.dashboard")
            local datetime = os.date("%a %b %d %H:%M")
            dashboard.section.header.val = {
              "      NEOVIM  ",
              "      " .. datetime .. "",
              "      ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━",
              "          +                         +                      _.._                    ",
              "                +                                        .' .-'`             +     ",
              "      +                                                 /  /     +                 ",
              "                             +                          |  |                       ",
              "                                                    +   \\  \\                       ",
              "           +                               +             '._'-._            +      ",
              "                                                            ```                    ",
              "                                   +                                               ",
              "                            /^--^\\     /^--^\\     /^--^\\                           ",
              "            +               \\____/     \\____/     \\____/                           ",
              "                           /      \\   /      \\   /      \\         +                ",
              "                          |        | |        | |        |                         ",
              "                           \\__  __/   \\__  __/   \\__  __/                          ",
              "      |^|^|^|^|^|^|^|^|^|^|^|^\\ \\^|^|^|^/ /^|^|^|^|^\\ \\^|^|^|^|^|^|^|^|^|^|^|^|    ",
              "      | | | | | | | | | | | | |\\ \\| | |/ /| | | | | | \\ \\ | | | | | | | | | | |    ",
              "      | | | | | | | | | | | | / / | | |\\ \\| | | | | |/ /| | | | | | | | | | | |    ",
              "      | | | | | | | | | | | | \\/| | | | \\/| | | | | |\\/ | | | | | | | | | | | |    ",
              "      #########################################################################    ",
            }

            dashboard.section.buttons.val = {
              dashboard.button("n", "🆕 > New file", function()
                  local fname = vim.fn.input("New file: ")
                  if fname ~= "" then
                      vim.cmd("edit " .. fname)
                      vim.cmd("startinsert")
                  end
              end),
              dashboard.button("f", "🔍  Find file", ":Telescope find_files<CR>"),
              dashboard.button("w", "👀  Find word", ":Telescope live_grep<CR>"),
              dashboard.button("r", "📗  Recent", ":Telescope oldfiles<CR>"),
              dashboard.button("q", "🚪  Quit", ":qa<CR>"),
            }

            alpha.setup(dashboard.opts)
          '';
        };

        harpoon = {
          package = pkgs.vimPlugins.harpoon2;
          setup = ''
            local harpoon = require("harpoon")
            harpoon:setup()
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
            vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
            vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
          '';
        };

        dressing = {
          package = pkgs.vimPlugins.dressing-nvim;
          setup = "require('dressing').setup({})";
        };
      };

      # =====================
      # Extra Lua Config
      # =====================
      luaConfigPost = ''
        -- Clipboard
        vim.opt.clipboard = "unnamedplus"

        -- Cursor line
        vim.opt.cursorline = true

        -- Extra indent settings
        vim.opt.softtabstop = 4
        vim.opt.expandtab = true
        vim.opt.smartindent = true

        -- Search settings
        vim.opt.incsearch = true
        vim.opt.ignorecase = true
        vim.opt.smartcase = true

        -- Scroll offset
        vim.opt.scrolloff = 10

        -- Diagnostics config
        vim.diagnostic.config({
          virtual_text = false,
          virtual_lines = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = {
            border = "rounded",
            source = true,
          },
          signs = {
            text = {
              [vim.diagnostic.severity.ERROR] = "",
              [vim.diagnostic.severity.WARN]  = "",
              [vim.diagnostic.severity.INFO]  = "",
              [vim.diagnostic.severity.HINT]  = "󰋼",
            },
            numhl = {
              [vim.diagnostic.severity.ERROR] = "ErrorMsg",
              [vim.diagnostic.severity.WARN]  = "WarningMsg",
            },
          },
        })

        -- Transparency
        vim.cmd [[
          highlight Normal guibg=none
          highlight NonText guibg=none
          highlight Normal ctermbg=none
          highlight NormalNC guibg=none
         highlight NormalFloat guibg=none
         highlight FloatBorder guibg=none
         highlight Pmenu guibg=none
         highlight PmenuSel guibg=none
         highlight SignColumn guibg=none
         highlight EndOfBuffer guibg=none
         highlight NeoTreeNormal guibg=none
         highlight NeoTreeNormalNC guibg=none
         highlight NeoTreeEndOfBuffer guibg=none
         highlight NeoTreeWinSeparator guibg=none
         highlight TelescopeNormal guibg=none
         highlight TelescopeBorder guibg=none
         highlight WhichKeyFloat guibg=none
         highlight BufferLineFill guibg=none
         highlight BufferLineBackground guibg=none
         highlight StatusLine guibg=none
         highlight StatusLineNC guibg=none
         highlight VertSplit guibg=none
         highlight WinSeparator guibg=none
         highlight NonText ctermbg=none
        ]]
      '';
    };
  };
}
