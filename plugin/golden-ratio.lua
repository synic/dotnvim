vim.pack.add({ "https://github.com/roman/golden-ratio" }, { load = function() end })

vim.g.golden_ratio_enabled = 0
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("golden-ratio")
		vim.cmd.GoldenRatioToggle()
	end,
})
