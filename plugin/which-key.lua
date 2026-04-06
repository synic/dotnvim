vim.pack.add({ "https://github.com/folke/which-key.nvim" }, { load = function() end })

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("which-key.nvim")
		local wk = require("which-key")
		local keymap = require("modules.keymap")
		wk.setup({
			preset = "modern",
			plugins = { spelling = true },
			icons = { mappings = false },
		})
		wk.add(keymap.categories)
	end,
})
