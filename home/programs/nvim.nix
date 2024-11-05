{ pkgs, inputs, ... }:

{
  home.packages = (
    with pkgs;
    [
      nixfmt-rfc-style
    ]
  );

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes = {
      gruvbox.enable = false;
      monokai-pro.enable = true;
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
        action = "<C-6>"; # switch to "previous" buffer
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
      {
        action = ''<cmd>lua require("telescope").extensions.yaml_schema.select_schema()<CR>'';
        key = "<leader>yss";
      }
    ];

    #####################
    ### Event Keymaps ###
    #####################
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
        map (keymap: {
          action = {
            __raw = keymap.action;
          };
          key = keymap.key;
          mode = "t";
          options = {
            noremap = true;
            buffer = true;
          };
        }) keymaps;
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
          "<leader>lds" = "lsp_document_symbols";
          "<leader>lws" = "lsp_workspace_symbols";
        };
      };

      web-devicons.enable = true;
      nvim-tree = {
        enable = true;
        git.ignore = false;
      };
      diffview.enable = true;
      comment.enable = true;
      treesitter.enable = true;
      nvim-autopairs.enable = true;
      noice.enable = true;
      nvim-jdtls = {
        enable = false;
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
            { name = "treesitter"; }
          ];
        };
      };
      cmp-nvim-lsp.enable = true;
      # cmp-buffer.enable = true;
      # cmp-dap.enable = true;
      # cmp-path.enable = true;
      cmp-treesitter.enable = true;
      # cmp_luasnip.enable = true;

      colorizer = {
        enable = true;
        settings.user_default_options = {
          mode = "virtualtext";
          rgb_fn = true;
        };
      };

      # plugins for languages
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

      # schemastore = {
      #   enable = true;
      #   json.enable = false;
      # };

      # LSP
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
            ca = "code_action";
          };
        };
        servers = {
          # nil-ls.enable = true;
          lua_ls.enable = true;
          yamlls = {
            enable = true;
            settings = {
              format.enable = true;
              schemas = {
                kubernetes = "/*.yaml";
                "https://json.schemastore.org/github-workflow.json" = "/.github/workflows/*";
                "https://json.schemastore.org/kustomization.json" = "kustomization.yaml";
                "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/argoproj.io/applicationset_v1alpha1.json" =
                  "/*.app.set.yaml";
                "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/argoproj.io/application_v1alpha1.json" =
                  "/*.app.yaml";
                "https://raw.githubusercontent.com/datreeio/CRDs-catalog/refs/heads/main/argoproj.io/appproject_v1alpha1.json" =
                  "/*.app.proj.yaml";
              };
              schemastore = {
                enable = true;
              };
            };
          };
          # pyright.enable = true;
          # jsonls.enable = true;
          html.enable = true;
          cssls.enable = true;
          tailwindcss.enable = false;
          # kotlin_language_server.enable = true;
          terraformls.enable = true;
          tinymist = {
            enable = true;
            settings.formatterMode = "typstyle";
          };
          nixd = {
            enable = true;
            settings = {
              nixpkgs.expr = "import <nixpkgs> { }";
              formatting.command = [ "nixfmt" ];
              options = {
                nixos.expr = "(builtins.getFlake (\"git+file://\" + toString ./.)).nixosConfigurations.nixos.options";
                "home-manager".expr =
                  "(builtins.getFlake (\"git+file://\" + toString ./.)).homeConfigurations.\"kevin@nixos\".options";
              };
            };
          };
        };
      };
    };
    autoCmd = [
      # {
      #   event = "FileType";
      #   pattern = "nix";
      #   command = "setlocal tabstop=2 shiftwidth=2";
      # }
      {
        event = "BufWritePre";
        pattern = "*";
        command = "lua vim.lsp.buf.format()";
      }
    ];

    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "yuck.vim";
        src = pkgs.fetchFromGitHub {
          owner = "elkowar";
          repo = "yuck.vim";
          rev = "9b5e0370f70cc30383e1dabd6c215475915fe5c3";
          hash = "sha256-F7aS8d6jJQQoIGkG2o4KNnDZAIrq0c+otIHvjdoGbtY=";
        };
      })
    ];
    #
    # extraPlugins = [
    #   # https://github.com/cenk1cenk2/schema-companion.nvim
    #   (pkgs.vimUtils.buildVimPlugin {
    #     name = "schema-companion";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "cenk1cenk2";
    #       repo = "schema-companion.nvim";
    #       rev = "1ab6768f19b32eac2c114091e801a0f8b538fdf0";
    #       hash = "sha256-sC4SFZ1kFgTuVRlhP3GKiBYqz5mi2eYiocMoz+HsyvU=";
    #     };
    #     buildInputs = with pkgs.vimPlugins; [
    #       plenary-nvim
    #       telescope-nvim
    #     ];
    #   })
    # ];
    #
    # extraConfigLua = builtins.readFile ./nvim_extra_config.lua;
  };
}
