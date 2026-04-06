vim.pack.add({ "https://github.com/kshenoy/vim-signature" }, { load = function() end })

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("vim-signature")
	end,
})
