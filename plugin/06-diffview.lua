vim.pack.add({ "https://github.com/sindrets/diffview.nvim" }, { load = function() end })

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("diffview.nvim")
	end,
})
