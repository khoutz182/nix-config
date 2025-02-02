local schema_companion = require("schema-companion").setup({
	enable_telescope = true,
	matchers = {
		require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
	},
})

require("lspconfig").yamlls.setup(require("schema-companion").setup_client({
	settings = {
		yaml = {
			format = {
				enable = true
			},
			schemas = {
				kubernetes = "/*.yaml",
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
			},
		},
	},
}))
