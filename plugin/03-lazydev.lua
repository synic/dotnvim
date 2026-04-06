vim.pack.add({ "https://github.com/folke/lazydev.nvim" }, { load = function() end })

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("LazydevSetup", { clear = true }),
	pattern = { "lua" },
	once = true,
	callback = function()
		vim.cmd.packadd("lazydev.nvim")
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
