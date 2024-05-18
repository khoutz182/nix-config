
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

require('telescope').setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--no-ignore-vcs",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		layout_config = {
			prompt_position = "bottom"
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<M-p>"] = action_layout.toggle_preview
			},
			n = {
				["<M-p>"] = action_layout.toggle_preview
			},
		},
		file_ignore_patterns = { "node_modules" },
	},
	pickers = {
--		find_files = {
--			theme = "dropdown",
--		},
	},
})
