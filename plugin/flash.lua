vim.pack.add({ "https://github.com/folke/flash.nvim" }, { load = function() end })
local target_keys = "asdfghjkletovxpzwciubrnym;,ASDFGHJKLETOVXPZWCIUBRNYM"

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("flash.nvim")
		require("flash").setup({
			modes = {
				char = { enabled = false },
			},
			labels = target_keys,
		})
	end,
})
