vim.pack.add({ "https://github.com/wansmer/treesj" }, { load = function() end })

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("treesj")
		require("treesj").setup({
			max_join_length = 2000,
			use_default_keymaps = false,
		})
	end,
})
