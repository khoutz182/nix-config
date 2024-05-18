-- https://github.com/nanotee/nvim-lua-guide

-- https://github.com/rockerBOO/awesome-neovim
-- https://github.com/NvChad/NvChad


local modules = {
	"core.lazy",
	"core.options",
	"config",
	"core.mappings"
}

for _, module in ipairs(modules) do
	local ok, err = pcall(require, module)
	if not ok then
		error("Error loading " .. module .. "\n\n" .. err)
	end
end


