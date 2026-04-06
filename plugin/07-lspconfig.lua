vim.pack.add({
	"https://github.com/nvimtools/none-ls.nvim",
	"https://github.com/davidmh/cspell.nvim",
	"https://github.com/nvimtools/none-ls-extras.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})

local lsp = require("modules.lsp")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local nonels_sources = {}

		for source, args in pairs(lsp.nonels) do
			if type(source) == "number" then
				table.insert(nonels_sources, require("null-ls.builtins." .. args))
			else
				table.insert(nonels_sources, require("null-ls.builtins." .. source).with(args))
			end
		end

		require("null-ls").setup({ sources = nonels_sources })
	end,
})
