vim.filetype.add({ extension = { templ = "templ" } })

return {
	servers = {
		["templ"] = { cmd = { "templ", "lsp" } },
	},
}
