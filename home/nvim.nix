{ ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes = {
      base16 = {
        enable = true;
        colorscheme = "gruvbox-dark-medium";
      };
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
    keymapsOnEvents = {
      TermOpen =
        let
          keymaps = [
            {
              action = "[[<C-\\><C-n>]]";
              key = "<esc>";
            }
            {
              action = "[[<C-\\><C-n><C-W>h]]";
              key = "<C-h>";
            }
            {
              action = "[[<C-\\><C-n><C-W>j]]";
              key = "<C-j>";
            }
            {
              action = "[[<C-\\><C-n><C-W>k]]";
              key = "<C-k>";
            }
            {
              action = "[[<C-\\><C-n><C-W>l]]";
              key = "<C-l>";
            }
          ];
        in
        map
          (keymap: {
            action = {
              __raw = keymap.action;
            };
            key = keymap.key;
            mode = "t";
            options = {
              noremap = true;
              buffer = true;
            };
          })
          keymaps;
      # TermOpen = [
      #   {
      #     action = {
      #       __raw = "[[<C-\\><C-n>]]";
      #     };
      #     key = "<esc>";
      #     mode = "t";
      #     options = {
      #       noremap = true;
      #       buffer = true;
      #     };
      #   }
      #   {
      #     action = {
      #       __raw = "[[<C-\\><C-n><C-W>h]]";
      #     };
      #     key = "<C-h>";
      #     mode = "t";
      #     options = {
      #       noremap = true;
      #       buffer = true;
      #     };
      #   }
      # ];
    };

    ###############
    ### Plugins ###
    ###############
    plugins = {
      lualine = {
        enable = true;
        settings = {
          options = {
            globalstatus = true;
          };
          sections = {
            lualine_c = [
              "filename"
              "navic"
            ];
          };
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

      web-devicons.enable = true;
      nvim-tree.enable = true;
      diffview.enable = true;
      comment.enable = true;
      treesitter.enable = true;
      nvim-autopairs.enable = true;
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
            default_settings = {
              cargo.features = "all";
            };
          };
        };
      };

      # Debugging
      dap = {
        enable = true;
        extensions = {
          dap-ui = {
            enable = true;
          };
        };
      };
      neotest = {
        enable = true;
        adapters = {
          rust.enable = true;
        };
      };
      helm.enable = true;

      toggleterm = {
        enable = true;
        settings = {
          direction = "float";
          float_opts = {
            border = "double";
          };
          shade_terminals = false;
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
        settings = {
          lsp = {
            auto_attach = true;
            preference = [ "nixd" ];
          };
        };
      };

      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
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
          lua_ls.enable = true;
          yamlls.enable = true;
          pyright.enable = true;
          jsonls.enable = true;
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = false;
          kotlin_language_server.enable = true;
          typst_lsp = {
            enable = true;
            settings = {
              experimentalFormatterMode = "on";
            };
          };
          nixd = {
            enable = true;
            settings = {
              nixpkgs.expr = "import <nixpkgs> { }";
              formatting.command = [ "nixpkgs-fmt" ];
              options = {
                nixos.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).nixosConfigurations.nixos.options";
                home_manager.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).homeConfigurations.kevin@nixos.options";
              };
            };
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
