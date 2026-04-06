vim.pack.add({ "https://github.com/akinsho/git-conflict.nvim" }, { load = function() end })

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("git-conflict.nvim")
		require("git-conflict").setup({})
	end,
})
