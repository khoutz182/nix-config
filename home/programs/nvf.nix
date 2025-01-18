{ ... }:

{
  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };

        options = {
          shiftwidth = 0;
          tabstop = 4;
        };

        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;

        lsp = {
          formatOnSave = true;
          # lightbulb.enable = true;
          # lspsaga.enable = true;
          nvim-docs-view.enable = true;
        };

        # debugger = {
        # 	nvim-dap = {
        # 		enable = true;
        # 		ui.enable = true;
        # 	};
        # };

        languages = {
          enableLSP = true;
          enableTreesitter = true;

          nix = {
            enable = true;
            format.enable = true;
          };
          rust = {
            enable = true;
            format.enable = true;
          };
        };

        terminal.toggleterm = {
          enable = true;
          setupOpts = {
            direction = "float";
          };
        };
      };
    };
  };
}
