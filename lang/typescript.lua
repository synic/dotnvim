return {
	treesitter = { "typescript", "javascript" },
	format_on_save = "nonels",
	nonels = {
		["formatting.prettier"] = {
			filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "templ", "svelte" },
		},
	},
	servers = {
		["ts_ls"] = { mason_name = "typescript-language-server", cmd = { "typescript-language-server" } },
	},
}
