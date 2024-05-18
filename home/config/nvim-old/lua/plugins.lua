return {
	"nvim-lua/plenary.nvim",
	"williamboman/mason.nvim",
	"williamboman/mason-lspconfig.nvim",
	"neovim/nvim-lspconfig",

	{"briones-gabriel/darcula-solid.nvim", dependencies = "rktjmp/lush.nvim"},

	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

	"SmiteshP/nvim-navic",

	-- completion
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/nvim-cmp",

	"lewis6991/gitsigns.nvim",

	-- lilypond
	{
		"martineausimon/nvim-lilypond-suite",
		dependencies = { "MunifTanjim/nui.nvim" }
	},

	-- snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "saadparwaiz1/cmp_luasnip" },
	},

	-- eww
	"elkowar/yuck.vim",
	"gpanders/nvim-parinfer",

	-- terraform
	"hashivim/vim-terraform",

	-- terminal integration
	"akinsho/toggleterm.nvim",

	-- status line
	"nvim-lualine/lualine.nvim",
	"kyazdani42/nvim-web-devicons",

	-- color helper
	"norcalli/nvim-colorizer.lua",

	-- LaTeX editing
	{ "lervag/vimtex", lazy = true },

	-- Commenting
	"numToStr/Comment.nvim",

	-- fuzzy finding
	{ 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

	{ 'kyazdani42/nvim-tree.lua', dependencies = { 'kyazdani42/nvim-web-devicons' } },
	{"sindrets/diffview.nvim", dependencies = { "nvim-lua/plenary.nvim" }},

	-- {
	-- 	"cameron-wags/rainbow_csv.nvim",
	-- 	config = function ()
	-- 		require "rainbow_csv".setup()
	-- 	end,
	-- 	module = {
	-- 		"rainbow_csv",
	-- 		"rainbow_csv.fns"
	-- 	},
	-- 	ft = {
	-- 		"csv",
	-- 		"tsv",
	-- 		"csv_semicolon",
	-- 		"csv_whitespace"
	-- 	}
	-- }
}
