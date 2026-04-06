vim.pack.add({ "https://github.com/folke/trouble.nvim" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("TroubleSetup", { clear = true }),
	callback = function()
		require("trouble").setup({})
	end,
})
