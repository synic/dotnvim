vim.pack.add({
	"https://github.com/nvimtools/none-ls.nvim",
	"https://github.com/davidmh/cspell.nvim",
	"https://github.com/nvimtools/none-ls-extras.nvim",
})

local lsp = require("modules.lsp")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local nonels_sources = {}

		for source, args in pairs(lsp.nonels) do
			if type(source) == "number" then
				if type(args) == "function" then
					table.insert(nonels_sources, args())
				else
					table.insert(nonels_sources, require("null-ls.builtins." .. args))
				end
			else
				table.insert(nonels_sources, require("null-ls.builtins." .. source).with(args))
			end
		end

		require("null-ls").setup({ sources = nonels_sources })
	end,
})
