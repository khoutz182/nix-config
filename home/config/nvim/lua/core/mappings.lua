local keymap = vim.keymap.set

local function map(mode, mapping, func, opts)
	keymap(mode, mapping, func, opts)
end

-- "," is the <leader>
map('n', ',', '', {})
-- vim.g.mapleader = ',' -- added to lazy


-- fuzzy finder
map('n', '<leader>ff', require('telescope.builtin').find_files)
map('', '<leader>fg', require('telescope.builtin').live_grep)
map('', '<leader>fb', require('telescope.builtin').buffers)
map('', '<leader>gs', require('telescope.builtin').grep_string)
map('', '<leader>ts', require('telescope.builtin').treesitter)

-- lsp commands
map('', '<leader>lds', require('telescope.builtin').lsp_document_symbols)
map('', '<leader>lws', require('telescope.builtin').lsp_workspace_symbols)

map('', '<leader>sv', ':luafile $HOME/.config/nvim/init.lua<CR>')
map('', '<leader>sc', ':so %<CR>')

-- switch between files
map('', '<leader>,', '<c-^><CR>')

-- buffer navigation
map('', '<C-J>', '<C-W><C-J>')
map('', '<C-K>', '<C-W><C-K>')
map('', '<C-L>', '<C-W><C-L>')
map('', '<C-H>', '<C-W><C-H>')
map('', '<leader>vs', ':vsplit<CR>')
map('', '<leader>hs', ':split<CR>')

map('n', '<C-n>', ':NvimTreeToggle<CR>')

map('n', '<C-t>', ':ToggleTerm<CR>')

-- system clipboard
map('', '<leader>y', '"+y')
map('', '<leader>p', '"+p')

