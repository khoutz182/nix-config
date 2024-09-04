{ ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes = {
      gruvbox.enable = true;
      # base16.colorscheme = "gruvbox-dark-medium";
    };

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 0; # when set to 0, the tabstop value will be used
      tabstop = 4;
      cindent = true;
      list = true;

      foldlevel = 99;
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    ###############
    ### Keymaps ###
    ###############
    globals.mapleader = ",";
    keymaps = [
      {
        action = "<cmd>NvimTreeToggle<CR>";
        key = "<C-n>";
      }
      {
        action = "<cmd>ToggleTerm<CR>";
        key = "<C-t>";
      }
      {
        action = "<c-^><CR>"; # switch to "previous" buffer
        key = "<leader>,";
      }
      {
        action = "<C-W><C-H>";
        key = "<C-H>";
      }
      {
        action = "<C-W><C-J>";
        key = "<C-J>";
      }
      {
        action = "<C-W><C-K>";
        key = "<C-K>";
      }
      {
        action = "<C-W><C-L>";
        key = "<C-L>";
      }
      {
        action = "<leader>y";
        key = ''\"+y'';
      }
      {
        action = "<leader>p";
        key = ''"+p'';
      }
    ];

    #####################
    ### Custom Config ###
    #####################
    # extraConfigLua = ''
    # 	local set_terminal_keymaps = function()
    # 		local opts = {noremap = true}
    # 		vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    # 		vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    # 		vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    # 		vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    # 		vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    # 	end
    # '';

    ###############
    ### Plugins ###
    ###############
    plugins = {
      lualine = {
        enable = true;
        globalstatus = true;
        sections = {
          lualine_c = [
            "filename"
            "navic"
          ];
        };
      };

      telescope = {
        enable = true;
        keymaps = {
          "<leader>fg" = "live_grep";
          "<leader>ff" = "find_files";
          "<leader>gs" = "grep_string";
          "<leader>ts" = "treesitter";
        };
      };

      nvim-tree.enable = true;
      diffview.enable = true;
      comment.enable = true;
      treesitter.enable = true;
      nvim-jdtls = {
        enable = true;
        # data = "~/src";
        data.__raw = "vim.fn.stdpath 'cache' .. '/jdtls/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t')";
        configuration = "~/.config/jdtls";
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "cmp-dap"; }
            # { name = "treesitter"; }
            # { name = "path"; }
            # { name = "buffer"; }
          ];
        };
      };
      cmp-nvim-lsp.enable = true;
      # cmp-buffer.enable = true;
      cmp-dap.enable = true;
      # cmp-path.enable = true;
      # cmp-treesitter.enable = true;
      cmp_luasnip.enable = true;

      nvim-colorizer = {
        enable = true;
        userDefaultOptions = {
          mode = "virtualtext";
          rgb_fn = true;
        };
      };

      # plugins for languages
      typst-vim.enable = true;
      rustaceanvim = {
        enable = true;
        settings = {
          server = {
            auto_attach = true;
          };
        };
      };
      helm.enable = true;

      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
        };
      };

      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
        };
      };

      navic = {
        enable = true;
        lsp.autoAttach = true;
        lsp.preference = [ "nixd" ];
      };

      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            # "<leader>k" = "goto_next";
            # "<leader>j" = "goto_prev";
            "[d" = "goto_prev";
            "]d" = "goto_next";
            "<space>e" = "open_float";
            "<space>q" = "setloclist";
          };
          lspBuf = {
            gd = "definition";
            K = "hover";
            gi = "implementation";
            gt = "type_definition";
            "<space>f" = "format";
          };
        };
        servers = {
          # nil-ls.enable = true;
          lua-ls.enable = true;
          yamlls.enable = true;
          pyright.enable = true;
          jsonls.enable = true;
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = false;
          kotlin-language-server.enable = true;
          typst-lsp = {
            enable = true;
            settings = {
              experimentalFormatterMode = "on";
            };
          };
          nixd = {
            enable = true;
            settings.formatting.command = [ "nixpkgs-fmt" ];
          };
        };
      };
    };
    autoCmd = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal tabstop=2 shiftwidth=2";
      }
      {
        event = "BufWritePre";
        pattern = "*";
        command = "lua vim.lsp.buf.format()";
      }
    ];
  };
}
