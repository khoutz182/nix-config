{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes = {
      base16 = {
        enable = true;
        colorscheme = "gruvbox-material-dark-medium";
      };
    };

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      cindent = true;
    };

    clipboard.providers.wl-copy.enable = true;

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
        key = "\"+y";
      }
      {
        action = "<leader>p";
        key = "\"+p";
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
            # {
            #   name = "navic.get_location";
            #   # extraConfig = {
            #   #   cond = "navic.is_available";
            #   # };
            # }
            "b:gitsigns_status"
          ];
        };
        # lualine_c = {
        # 	'filename',
        # 	{ navic.get_location, cond = navic.is_available },
        # 	"b:gitsigns_blame_line"
        # },
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
      toggleterm.enable = true;
      gitsigns.enable = true;
      diffview.enable = true;
      comment-nvim.enable = true;
      treesitter.enable = true;
      nvim-cmp.enable = true;
      cmp-nvim-lsp.enable = true;

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
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_prev";
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
          nil_ls.enable = true;
          lua-ls.enable = true;
          yamlls.enable = true;
          pyright.enable = true;
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          nixd = {
            enable = true;
            settings.formatting.command = "nixpkgs-fmt";
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
