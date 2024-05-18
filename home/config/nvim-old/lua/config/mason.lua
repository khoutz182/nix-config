require("mason").setup()
require("mason-lspconfig").setup()

-- navigation
local navic = require("nvim-navic")

-- border for prettiness
-- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
-- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' }),
}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	navic.attach(client, bufnr)

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set('n', '<space>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require("mason-lspconfig").setup_handlers {
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup {
			handlers = handlers,
			on_attach = on_attach
		}
	end,

	-- Next, you can provide a dedicated handler for specific servers.
	-- For example, a handler override for the `rust_analyzer`:
	-- ["rust_analyzer"] = function ()
	-- 	require("rust-tools").setup {}
	-- end
	["lua_ls"] = function()
		require("lspconfig").lua_ls.setup {
			handlers = handlers,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }
					}
				}
			}
		}
	end,

	["yamlls"] = function()
		require("lspconfig").yamlls.setup {
			handlers = handlers,
			on_attach = on_attach,
			settings = {
				yaml = {
					format = {
						enable = true,
					},
					schemas = {
						["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
						["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
						["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.9/all.json"] = "/*.k8s.yaml"
					}
				}
			}
		}
	end,

	["texlab"] = function()
		require("lspconfig").texlab.setup {
			handlers = handlers,
			on_attach = on_attach,
			settings = {
				texlab = {
					auxDirectory = ".texlab",
					build = {
						args = { "-pdf", "-xelatex", "-interaction=nonstopmode", "-synctex=1", "-outdir=.texlab", "-pv", "%f" },
						onSave = true
					}
				}
			}
		}
	end
}
