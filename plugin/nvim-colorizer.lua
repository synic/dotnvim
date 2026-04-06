vim.pack.add({ { src = "https://github.com/norcalli/nvim-colorizer.lua", name = "colorizer" } }, { load = function() end })

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("colorizer")
		require("colorizer").setup({
			"javascript",
			"css",
			"html",
			"templ",
			"sass",
			"scss",
			"typescript",
			"json",
			"lua",
		})
	end,
})
