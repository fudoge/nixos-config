# nvf Home Manager Module Configuration
# 기존 Lua 설정을 nvf로 마이그레이션
{ inputs, pkgs, lib, ... }:

{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        # ============================================
        # 기본 설정 (config/options.lua, globals.lua)
        # ============================================
        viAlias = false;
        vimAlias = false;

        globals = {
          mapleader = " ";
          maplocalleader = " ";
        };

        options = {
          # tab/indent
          tabstop = 4;
          shiftwidth = 4;
          softtabstop = 4;
          expandtab = true;
          smartindent = true;
          wrap = false;

          # search
          incsearch = true;
          ignorecase = true;
          smartcase = true;

          # visual
          number = true;
          relativenumber = true;
          termguicolors = true;
          signcolumn = "yes";

          # etc
          encoding = "UTF-8";
          cmdheight = 1;
          scrolloff = 10;
          mouse = "a";
        };

        # ============================================
        # 테마 설정 (gruvbox)
        # ============================================
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        # ============================================
        # 상태바 (lualine)
        # ============================================
        statusline.lualine = {
          enable = true;
          theme = "gruvbox";
        };

        # ============================================
        # 탭/버퍼라인 (barbar 대신 bufferline 사용)
        # ============================================
        tabline.nvimBufferline = {
          enable = true;
          setupOpts = {
            options = {
              numbers = "ordinal";
              diagnostics = "nvim_lsp";
              show_buffer_close_icons = true;
              show_close_icon = false;
              separator_style = "slant";
            };
          };
        };

        # ============================================
        # 파일 탐색기 (neo-tree)
        # ============================================
        filetree.neo-tree = {
          enable = true;
          setupOpts = {
            close_if_last_window = true;
            popup_border_style = "rounded";
            window = {
              width = 30;
              mappings = {
                "<space>" = "none";
              };
            };
          };
        };

        # ============================================
        # Telescope
        # ============================================
        telescope = {
          enable = true;
          setupOpts = {
            defaults = {
              file_ignore_patterns = [ "node_modules" ".git/" ];
              layout_strategy = "horizontal";
            };
          };
        };

        # ============================================
        # Treesitter
        # ============================================
        treesitter = {
          enable = true;
          fold = true;
          highlight.enable = true;
          indent.enable = true;

          grammars = [
            "bash"
            "c"
            "cpp"
            "css"
            "dockerfile"
            "go"
            "gomod"
            "gosum"
            "hcl"
            "html"
            "java"
            "javascript"
            "json"
            "lua"
            "markdown"
            "markdown_inline"
            "nix"
            "python"
            "rust"
            "sql"
            "terraform"
            "toml"
            "typescript"
            "yaml"
          ];
        };

        # ============================================
        # LSP 설정
        # ============================================
        lsp = {
          enable = true;
          formatOnSave = true;

          lspconfig = {
            enable = true;
            sources = {};
          };

          # lspsaga 활성화
          lspsaga = {
            enable = true;
          };

          # 진단 표시
          lspSignature.enable = true;
          lsplines.enable = true;
        };

        # ============================================
        # 언어별 설정
        # ============================================
        languages = {
          enableLSP = true;
          enableTreesitter = true;
          enableFormat = true;

          # Nix
          nix = {
            enable = true;
            format = {
              enable = true;
              type = "nixfmt";
            };
            lsp = {
              enable = true;
              server = "nil";
            };
          };

          # Rust
          rust = {
            enable = true;
            crates.enable = true;
            format.enable = true;
            lsp = {
              enable = true;
              opts = ''
                ["rust-analyzer"] = {
                  cargo = { allFeatures = true },
                  check = { command = "clippy" },
                  inlayHints = { enable = true },
                  diagnostics = { enable = true },
                }
              '';
            };
          };

          # Go
          go = {
            enable = true;
            format.enable = true;
            lsp = {
              enable = true;
              opts = ''
                gopls = {
                  analyses = {
                    unusedparams = true,
                    nilness = true,
                    shadow = true,
                  },
                  staticcheck = true,
                  gofumpt = true,
                }
              '';
            };
          };

          # Python
          python = {
            enable = true;
            format = {
              enable = true;
              type = "black";
            };
            lsp = {
              enable = true;
              server = "pyright";
            };
          };

          # TypeScript / JavaScript
          ts = {
            enable = true;
            format = {
              enable = true;
              type = "prettier";
            };
            lsp.enable = true;
          };

          # HTML
          html = {
            enable = true;
            format.enable = true;
          };

          # CSS
          css = {
            enable = true;
          };

          # C/C++
          clang = {
            enable = true;
            format = {
              enable = true;
              type = "clang-format";
            };
            lsp = {
              enable = true;
              opts = ''
                cmd = { "clangd", "--header-insertion=never", "--fallback-style=Google" }
              '';
            };
          };

          # Markdown
          markdown = {
            enable = true;
            format.enable = true;
          };

          # YAML
          yaml = {
            enable = true;
            format.enable = true;
          };

          # SQL
          sql = {
            enable = true;
            format.enable = true;
          };

          # Bash
          bash = {
            enable = true;
            format.enable = true;
          };

          # Lua
          lua = {
            enable = true;
            format = {
              enable = true;
              type = "stylua";
            };
            lsp.enable = true;
          };
        };

        # ============================================
        # 자동완성 (nvim-cmp)
        # ============================================
        autocomplete.nvim-cmp = {
          enable = true;
          mappings = {
            confirm = "<CR>";
            complete = "<C-Space>";
            scrollDocsUp = "<C-b>";
            scrollDocsDown = "<C-f>";
            close = "<C-e>";
          };
          sources = {
            nvim_lsp = { enable = true; };
            buffer = { enable = true; };
            path = { enable = true; };
            luasnip = { enable = true; };
          };
        };

        # ============================================
        # Snippets
        # ============================================
        snippets.luasnip = {
          enable = true;
          providers = [ "friendly-snippets" ];
        };

        # ============================================
        # Git 통합
        # ============================================
        git = {
          enable = true;
          gitsigns = {
            enable = true;
            setupOpts = {
              current_line_blame = true;
              signs = {
                add = { text = "│"; };
                change = { text = "│"; };
                delete = { text = "_"; };
                topdelete = { text = "‾"; };
                changedelete = { text = "~"; };
              };
            };
          };
        };

        # ============================================
        # UI 개선
        # ============================================
        ui = {
          # 들여쓰기 가이드
          indent-blankline = {
            enable = true;
          };

          # 아이콘
          icons.enable = true;

          # breadcrumbs
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };

          # noice (fancy cmdline, notifications)
          noice.enable = true;
        };

        # 색상 미리보기
        utility.preview.markdownPreview.enable = true;

        # ============================================
        # 자동 페어
        # ============================================
        autopairs.nvim-autopairs = {
          enable = true;
        };

        # ============================================
        # 주석
        # ============================================
        comments.comment-nvim = {
          enable = true;
        };

        # ============================================
        # 키맵 설정 (config/keymaps.lua)
        # ============================================
        maps = {
          normal = {
            # Neo-tree 토글
            "<leader>e" = {
              action = "<cmd>Neotree toggle<CR>";
              desc = "Toggle file explorer";
            };

            # 창 이동
            "<C-h>" = { action = "<C-w>h"; desc = "Move to left window"; };
            "<C-j>" = { action = "<C-w>j"; desc = "Move to bottom window"; };
            "<C-k>" = { action = "<C-w>k"; desc = "Move to top window"; };
            "<C-l>" = { action = "<C-w>l"; desc = "Move to right window"; };

            # 검색 하이라이트 제거
            "<leader>h" = {
              action = "<cmd>nohlsearch<CR>";
              desc = "Clear search highlights";
            };

            # 버퍼 이동 (bufferline)
            "<A-,>" = { action = "<cmd>BufferLineCyclePrev<CR>"; desc = "Previous buffer"; };
            "<A-.>" = { action = "<cmd>BufferLineCycleNext<CR>"; desc = "Next buffer"; };
            "<A-c>" = { action = "<cmd>bdelete<CR>"; desc = "Close buffer"; };

            # 버퍼 번호로 이동
            "<A-1>" = { action = "<cmd>BufferLineGoToBuffer 1<CR>"; desc = "Go to buffer 1"; };
            "<A-2>" = { action = "<cmd>BufferLineGoToBuffer 2<CR>"; desc = "Go to buffer 2"; };
            "<A-3>" = { action = "<cmd>BufferLineGoToBuffer 3<CR>"; desc = "Go to buffer 3"; };
            "<A-4>" = { action = "<cmd>BufferLineGoToBuffer 4<CR>"; desc = "Go to buffer 4"; };
            "<A-5>" = { action = "<cmd>BufferLineGoToBuffer 5<CR>"; desc = "Go to buffer 5"; };

            # Telescope
            "<leader>ff" = { action = "<cmd>Telescope find_files<CR>"; desc = "Find files"; };
            "<leader>fg" = { action = "<cmd>Telescope live_grep<CR>"; desc = "Live grep"; };
            "<leader>fb" = { action = "<cmd>Telescope buffers<CR>"; desc = "Find buffers"; };
            "<leader>fh" = { action = "<cmd>Telescope help_tags<CR>"; desc = "Help tags"; };

            # LSP
            "gd" = { action = "<cmd>lua vim.lsp.buf.definition()<CR>"; desc = "Go to definition"; };
            "<leader>ca" = { action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; desc = "Code actions"; };
            "K" = { action = "<cmd>lua vim.lsp.buf.hover()<CR>"; desc = "Hover documentation"; };
            "<leader>rn" = { action = "<cmd>lua vim.lsp.buf.rename()<CR>"; desc = "Rename symbol"; };
            "gr" = { action = "<cmd>Telescope lsp_references<CR>"; desc = "Find references"; };

            # Gitsigns
            "<leader>hs" = { action = "<cmd>Gitsigns stage_hunk<CR>"; desc = "Stage hunk"; };
            "<leader>hr" = { action = "<cmd>Gitsigns reset_hunk<CR>"; desc = "Reset hunk"; };
            "<leader>hb" = { action = "<cmd>Gitsigns blame_line<CR>"; desc = "Blame line"; };
            "]c" = { action = "<cmd>Gitsigns next_hunk<CR>"; desc = "Next hunk"; };
            "[c" = { action = "<cmd>Gitsigns prev_hunk<CR>"; desc = "Previous hunk"; };

            # 저장 단축키
            "<C-s>" = { action = "<cmd>w<CR>"; desc = "Save file"; };
          };

          visual = {
            # 들여쓰기 유지
            "<" = { action = "<gv"; desc = "Indent left"; };
            ">" = { action = ">gv"; desc = "Indent right"; };
          };

          insert = {
            # 저장 단축키
            "<C-s>" = { action = "<Esc><cmd>w<CR>"; desc = "Save file"; };
          };
        };

        # ============================================
        # 추가 플러그인 (nvf에 내장되지 않은 것들)
        # ============================================
        extraPlugins = {
          # Harpoon
          harpoon = {
            package = pkgs.vimPlugins.harpoon2;
            setup = ''
              local harpoon = require("harpoon")
              harpoon:setup()

              vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add to Harpoon" })
              vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
              vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
              vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
            '';
          };

          # nvim-ts-autotag (HTML 태그 자동 닫기)
          nvim-ts-autotag = {
            package = pkgs.vimPlugins.nvim-ts-autotag;
            setup = ''
              require('nvim-ts-autotag').setup()
            '';
          };

          # colorizer (색상 코드 미리보기)
          nvim-colorizer = {
            package = pkgs.vimPlugins.nvim-colorizer-lua;
            setup = ''
              require('colorizer').setup()
            '';
          };

          # dressing (UI 개선)
          dressing = {
            package = pkgs.vimPlugins.dressing-nvim;
            setup = ''
              require('dressing').setup()
            '';
          };
        };

        # ============================================
        # 추가 Lua 설정
        # ============================================
        luaConfigRC.custom = ''
          -- Markdown Preview 설정
          vim.g.mkdp_auto_start = 0
          vim.g.mkdp_auto_close = 0
          vim.g.mkdp_port = '8894'
          vim.g.mkdp_filetypes = { "markdown" }

          -- 클립보드 통합
          vim.opt.clipboard = "unnamedplus"

          -- 커서 라인 하이라이트
          vim.opt.cursorline = true

          -- 분할 방향
          vim.opt.splitright = true
          vim.opt.splitbelow = true

          -- 백업 파일 비활성화
          vim.opt.backup = false
          vim.opt.writebackup = false
          vim.opt.swapfile = false

          -- 업데이트 시간 (더 빠른 반응)
          vim.opt.updatetime = 250

          -- Which-key 지연시간
          vim.opt.timeoutlen = 300
        '';
      };
    };
  };
}