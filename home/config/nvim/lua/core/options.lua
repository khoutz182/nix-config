local o = vim.o
local wo = vim.wo
local bo = vim.bo
local opt = vim.opt

-- global options
o.swapfile = true
o.dir = '/tmp'
o.smartcase = true
--o.laststatus = 3
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.scrolloff = 8
o.sidescrolloff = 8
o.termguicolors = true
o.hidden = true
o.ls = 0 -- last status
o.ch = 0 -- command height
-- o.undodir = "~/.vimdid"
o.undofile = true
--o.expandtab = true
o.tabstop = 4
o.shiftwidth = 4
o.showmode = false
o.shortmess = o.shortmess .. 'c'

-- window scoped options
--wo.relativenumber = true
wo.number = true
wo.wrap = false

-- buffer local options
-- TODO: yaml indent fixes
-- bo.indentkeys = bo.indentkeys - "0#"
bo.expandtab = true

-- :set things
opt.completeopt = {'noinsert', 'menuone', 'noselect'}
opt.diffopt = opt.diffopt + "vertical"
opt.encoding = "utf-8"

vim.g.python3_host_prog = '/usr/bin/python3'

vim.cmd [[
	filetype plugin indent on
	set indentkeys-=0#

	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerCompile
	augroup end
]]

