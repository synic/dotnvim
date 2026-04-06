vim.pack.add(
	{ { src = "https://github.com/kylechui/nvim-surround", version = vim.version.range("3") } },
	{ load = function() end }
)

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("nvim-surround")
		require("nvim-surround").setup({
			surrounds = {
				["%"] = {
					add = function()
						if vim.bo.filetype == "elixir" then
							return {
								"%{",
								"}",
							}
						end
					end,
				},
			},
		})
	end,
})
