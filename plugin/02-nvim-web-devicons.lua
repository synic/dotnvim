vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local yaml_icon = vim.fn.nr2char(0xE60B)
		require("nvim-web-devicons").setup({
			override_by_extension = {
				yml = { icon = yaml_icon, color = "#cb171e", cterm_color = "160", name = "Yml" },
				yaml = { icon = yaml_icon, color = "#cb171e", cterm_color = "160", name = "Yaml" },
			},
		})
	end,
})
