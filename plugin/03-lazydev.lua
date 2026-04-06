vim.pack.add({ "https://github.com/folke/lazydev.nvim" })

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("LazydevSetup", { clear = true }),
	pattern = { "lua" },
	callback = function()
		require("lazydev").setup({
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "lazy.nvim", words = { "LazyVim" } },
				{ path = "which-key.nvim", words = { "WhichKey" } },
				{ path = "blink.cmp", words = { "Blink" } },
			},
		})
	end,
})
