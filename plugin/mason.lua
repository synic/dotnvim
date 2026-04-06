vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local lsp = require("modules.lsp")
		require("mason").setup({})
		require("mason-lspconfig").setup({
			automatic_enable = lsp.mason_servers,
			ensure_installed = lsp.mason_servers,
		})
	end,
})
