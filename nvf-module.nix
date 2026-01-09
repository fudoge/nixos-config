# nvf-module.nix
# Simplified nvf configuration for latest nvf version
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

      # 기본 옵션
      options = {
        tabstop = 4;
        shiftwidth = 4;
        mouse = "a";
        termguicolors = true;
        signcolumn = "yes";
        wrap = false;
        cursorlineopt = "both";
        updatetime = 250;
        tm = 300;
        splitright = true;
        splitbelow = true;
      };

      # 줄 번호 모드
      lineNumberMode = "relNumber";

      # 검색 설정
      searchCase = "smart";

      # 백업 파일 방지
      preventJunkFiles = true;

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
      ui = {
        borders.enable = true;
        illuminate.enable = true;
        colorizer.enable = true;
        indent-blankline.enable = true;
        noice.enable = true;
      };

      # 상태바
      statusline.lualine = {
        enable = true;
        theme = "gruvbox";
      };

      # 버퍼라인
      tabline.nvimBufferline.enable = true;

      # 파일 트리
      filetree.neo-tree = {
        enable = true;
        setupOpts = {
          close_if_last_window = true;
        };
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
        autotagHtml = true;
        addDefaultGrammars = true;
        grammars = [
          "bash" "c" "cpp" "css" "dockerfile" "go" "gomod" "gosum"
          "hcl" "html" "java" "javascript" "json" "lua" "markdown"
          "markdown_inline" "nix" "python" "rust" "sql" "terraform"
          "toml" "tsx" "typescript" "yaml"
        ];
      };

      # =====================
      # LSP
      # =====================
      lsp = {
        enable = true;
        formatOnSave = true;
      };

      # =====================
      # 언어별 설정
      # =====================
      languages = {
        enableLSP = true;
        enableTreesitter = true;
        enableFormat = true;

        # 각 언어 활성화만 - 세부 옵션은 기본값 사용
        nix.enable = true;
        rust = {
          enable = true;
          crates.enable = true;
        };
        go.enable = true;
        python.enable = true;
        ts.enable = true;
        html.enable = true;
        css.enable = true;
        clang.enable = true;
        markdown.enable = true;
        yaml.enable = true;
        sql.enable = true;
        bash.enable = true;
        lua.enable = true;
      };

      # =====================
      # 자동완성
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
      # Git
      # =====================
      git = {
        enable = true;
        gitsigns = {
          enable = true;
          setupOpts = {
            current_line_blame = true;
          };
        };
      };

      # =====================
      # 기타 기능
      # =====================
      autopairs.nvim-autopairs.enable = true;
      comments.comment-nvim.enable = true;

      # Which-key
      binds.whichKey.enable = true;

      # =====================
      # 키맵
      # =====================
      keymaps = [
        # Neo-tree
        {
          key = "<leader>e";
          mode = "n";
          action = "<cmd>Neotree toggle<CR>";
          desc = "Toggle file explorer";
        }

        # 창 이동
        { key = "<C-h>"; mode = "n"; action = "<C-w>h"; desc = "Move left"; }
        { key = "<C-j>"; mode = "n"; action = "<C-w>j"; desc = "Move down"; }
        { key = "<C-k>"; mode = "n"; action = "<C-w>k"; desc = "Move up"; }
        { key = "<C-l>"; mode = "n"; action = "<C-w>l"; desc = "Move right"; }

        # 검색 하이라이트 제거
        { key = "<leader>h"; mode = "n"; action = "<cmd>nohlsearch<CR>"; desc = "Clear highlights"; }

        # 버퍼 이동
        { key = "<A-,>"; mode = "n"; action = "<cmd>BufferLineCyclePrev<CR>"; desc = "Previous buffer"; }
        { key = "<A-.>"; mode = "n"; action = "<cmd>BufferLineCycleNext<CR>"; desc = "Next buffer"; }
        { key = "<A-c>"; mode = "n"; action = "<cmd>bdelete<CR>"; desc = "Close buffer"; }

        # Telescope
        { key = "<leader>ff"; mode = "n"; action = "<cmd>Telescope find_files<CR>"; desc = "Find files"; }
        { key = "<leader>fg"; mode = "n"; action = "<cmd>Telescope live_grep<CR>"; desc = "Live grep"; }
        { key = "<leader>fb"; mode = "n"; action = "<cmd>Telescope buffers<CR>"; desc = "Buffers"; }
        { key = "<leader>fh"; mode = "n"; action = "<cmd>Telescope help_tags<CR>"; desc = "Help tags"; }

        # LSP
        { key = "gd"; mode = "n"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; desc = "Go to definition"; }
        { key = "<leader>ca"; mode = "n"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; desc = "Code actions"; }
        { key = "K"; mode = "n"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; desc = "Hover"; }
        { key = "<leader>rn"; mode = "n"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; desc = "Rename"; }
        { key = "gr"; mode = "n"; action = "<cmd>Telescope lsp_references<CR>"; desc = "References"; }

        # Gitsigns
        { key = "<leader>hs"; mode = "n"; action = "<cmd>Gitsigns stage_hunk<CR>"; desc = "Stage hunk"; }
        { key = "<leader>hr"; mode = "n"; action = "<cmd>Gitsigns reset_hunk<CR>"; desc = "Reset hunk"; }
        { key = "<leader>hb"; mode = "n"; action = "<cmd>Gitsigns blame_line<CR>"; desc = "Blame"; }
        { key = "]c"; mode = "n"; action = "<cmd>Gitsigns next_hunk<CR>"; desc = "Next hunk"; }
        { key = "[c"; mode = "n"; action = "<cmd>Gitsigns prev_hunk<CR>"; desc = "Prev hunk"; }

        # 저장
        { key = "<C-s>"; mode = "n"; action = "<cmd>w<CR>"; desc = "Save"; }
        { key = "<C-s>"; mode = "i"; action = "<Esc><cmd>w<CR>"; desc = "Save"; }

        # 들여쓰기 유지
        { key = "<"; mode = "v"; action = "<gv"; desc = "Indent left"; }
        { key = ">"; mode = "v"; action = ">gv"; desc = "Indent right"; }
      ];

      # =====================
      # 추가 플러그인
      # =====================
      extraPlugins = {
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

        dressing = {
          package = pkgs.vimPlugins.dressing-nvim;
          setup = "require('dressing').setup()";
        };
      };

      # =====================
      # 추가 Lua 설정
      # =====================
      luaConfigPost = ''
        -- 클립보드 통합
        vim.opt.clipboard = "unnamedplus"

        -- 커서라인
        vim.opt.cursorline = true

        -- 탭/인덴트 추가 설정
        vim.opt.softtabstop = 4
        vim.opt.expandtab = true
        vim.opt.smartindent = true

        -- 검색
        vim.opt.incsearch = true
        vim.opt.ignorecase = true
        vim.opt.smartcase = true

        -- 스크롤 오프셋
        vim.opt.scrolloff = 10

        -- 인코딩
        vim.opt.encoding = "UTF-8"

        -- 커맨드 높이
        vim.opt.cmdheight = 1
      '';
    };
  };
}