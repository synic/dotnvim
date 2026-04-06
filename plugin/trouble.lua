vim.pack.add({ "https://github.com/folke/trouble.nvim" }, { load = function() end })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("TroubleSetup", { clear = true }),
	once = true,
	callback = function()
		vim.cmd.packadd("trouble.nvim")
		require("trouble").setup({})
	end,
})
