# nvf-module.nix
# 기존 Home Manager 설정에 import해서 사용
#
# 사용법:
# 1. flake.nix inputs에 nvf 추가:
#    nvf.url = "github:notashelf/nvf";
#    nvf.inputs.nixpkgs.follows = "nixpkgs";
#
# 2. home-manager 모듈에서 import:
#    imports = [ ./nvf-module.nix ];
#
# 3. extraSpecialArgs로 inputs 전달 필요:
#    home-manager.extraSpecialArgs = { inherit inputs; };

{ inputs, pkgs, lib, config, ... }:

{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;

    settings.vim = {
      # =====================
      # 기본 설정
      # =====================
      viAlias = true;
      vimAlias = true;

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      options = {
        tabstop = 4;
        shiftwidth = 4;
        softtabstop = 4;
        expandtab = true;
        smartindent = true;
        wrap = false;
        incsearch = true;
        ignorecase = true;
        smartcase = true;
        number = true;
        relativenumber = true;
        termguicolors = true;
        signcolumn = "yes";
        encoding = "UTF-8";
        cmdheight = 1;
        scrolloff = 10;
        mouse = "a";
        cursorline = true;
        splitright = true;
        splitbelow = true;
        updatetime = 250;
        timeoutlen = 300;
        clipboard = "unnamedplus";
      };

      # =====================
      # 테마
      # =====================
      theme = {
        enable = true;
        name = "gruvbox";
        style = "dark";
      };

      # =====================
      # UI
      # =====================
      statusline.lualine = {
        enable = true;
        theme = "gruvbox";
      };

      tabline.nvimBufferline = {
        enable = true;
        setupOpts.options = {
          numbers = "ordinal";
          diagnostics = "nvim_lsp";
          separator_style = "slant";
        };
      };

      filetree.neo-tree = {
        enable = true;
        setupOpts = {
          close_if_last_window = true;
          popup_border_style = "rounded";
          window.width = 30;
        };
      };

      ui = {
        indent-blankline.enable = true;
        icons.enable = true;
        breadcrumbs.enable = true;
        noice.enable = true;
      };

      # =====================
      # 검색 & 탐색
      # =====================
      telescope.enable = true;

      # =====================
      # Treesitter
      # =====================
      treesitter = {
        enable = true;
        fold = true;
        highlight.enable = true;
        indent.enable = true;
        grammars = [
          "bash" "c" "cpp" "css" "dockerfile" "go" "gomod" "gosum"
          "hcl" "html" "java" "javascript" "json" "lua" "markdown"
          "markdown_inline" "nix" "python" "rust" "sql" "terraform"
          "toml" "typescript" "yaml"
        ];
      };

      # =====================
      # LSP
      # =====================
      lsp = {
        enable = true;
        formatOnSave = true;
        lspconfig.enable = true;
        lspsaga.enable = true;
        lspSignature.enable = true;
      };

      # =====================
      # 언어별 설정
      # =====================
      languages = {
        enableLSP = true;
        enableTreesitter = true;
        enableFormat = true;

        nix = {
          enable = true;
          format = { enable = true; type = "nixfmt"; };
          lsp = { enable = true; server = "nil"; };
        };

        rust = {
          enable = true;
          crates.enable = true;
          format.enable = true;
          lsp.enable = true;
        };

        go = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
        };

        python = {
          enable = true;
          format = { enable = true; type = "black"; };
          lsp = { enable = true; server = "pyright"; };
        };

        ts = {
          enable = true;
          format = { enable = true; type = "prettier"; };
          lsp.enable = true;
        };

        html.enable = true;
        css.enable = true;

        clang = {
          enable = true;
          format = { enable = true; type = "clang-format"; };
          lsp.enable = true;
        };

        markdown = {
          enable = true;
          format.enable = true;
        };

        yaml.enable = true;
        sql.enable = true;
        bash.enable = true;

        lua = {
          enable = true;
          format = { enable = true; type = "stylua"; };
          lsp.enable = true;
        };
      };

      # =====================
      # 자동완성 & Snippets
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

      snippets.luasnip = {
        enable = true;
        providers = [ "friendly-snippets" ];
      };

      # =====================
      # Git
      # =====================
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
            };
          };
        };
      };

      # =====================
      # 기타 기능
      # =====================
      autopairs.nvim-autopairs.enable = true;
      comments.comment-nvim.enable = true;
      utility.preview.markdownPreview.enable = true;

      # =====================
      # 키맵
      # =====================
      maps = {
        normal = {
          "<leader>e" = { action = "<cmd>Neotree toggle<CR>"; desc = "Toggle explorer"; };
          "<C-h>" = { action = "<C-w>h"; };
          "<C-j>" = { action = "<C-w>j"; };
          "<C-k>" = { action = "<C-w>k"; };
          "<C-l>" = { action = "<C-w>l"; };
          "<leader>h" = { action = "<cmd>nohlsearch<CR>"; desc = "Clear highlights"; };
          "<A-,>" = { action = "<cmd>BufferLineCyclePrev<CR>"; };
          "<A-.>" = { action = "<cmd>BufferLineCycleNext<CR>"; };
          "<A-c>" = { action = "<cmd>bdelete<CR>"; };
          "<leader>ff" = { action = "<cmd>Telescope find_files<CR>"; };
          "<leader>fg" = { action = "<cmd>Telescope live_grep<CR>"; };
          "<leader>fb" = { action = "<cmd>Telescope buffers<CR>"; };
          "gd" = { action = "<cmd>lua vim.lsp.buf.definition()<CR>"; };
          "<leader>ca" = { action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; };
          "K" = { action = "<cmd>lua vim.lsp.buf.hover()<CR>"; };
          "<leader>rn" = { action = "<cmd>lua vim.lsp.buf.rename()<CR>"; };
          "<C-s>" = { action = "<cmd>w<CR>"; };
        };
        visual = {
          "<" = { action = "<gv"; };
          ">" = { action = ">gv"; };
        };
        insert = {
          "<C-s>" = { action = "<Esc><cmd>w<CR>"; };
        };
      };

      # =====================
      # 추가 플러그인
      # =====================
      extraPlugins = {
        harpoon = {
          package = pkgs.vimPlugins.harpoon2;
          setup = ''
            local harpoon = require("harpoon")
            harpoon:setup()
            vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
            vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)
          '';
        };
        nvim-ts-autotag = {
          package = pkgs.vimPlugins.nvim-ts-autotag;
          setup = "require('nvim-ts-autotag').setup()";
        };
        nvim-colorizer = {
          package = pkgs.vimPlugins.nvim-colorizer-lua;
          setup = "require('colorizer').setup()";
        };
        dressing = {
          package = pkgs.vimPlugins.dressing-nvim;
          setup = "require('dressing').setup()";
        };
      };
    };
  };
}