-- setup defined here: https://github.com/ngalaiko/tree-sitter-go-template
--
-- [[set ft=yaml]]
local group = vim.api.nvim_create_augroup("helm", {clear = false})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
	pattern = {
		"*/templates/*.yaml",
		"*/templates/*.tpl",
		"*.gotmpl",
		"helmfile.yaml"
	},
	callback = function()
		vim.diagnostic.disable()
		vim.bo.filetype = "gotmpl"
		vim.bo.expandtab = true
		vim.bo.smartindent = true
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
	end,
	group = group
})
