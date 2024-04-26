
local plugins = {
	"lspconfig",
	"mason",
	"lualine",
	"colorizer",
	"telescope",
 	"cmp",
	"treesitter",
	"nvimtree",
	"toggleterm",
	"comment",
	"colorscheme",
	"diffview",
	"gitsigns",
}

for _, plugin in ipairs(plugins) do
	local ok, err = pcall(require, "config." .. plugin)
	if not ok then
		error("Error loading " .. plugin .. "\n\n" .. err)
	end
end
