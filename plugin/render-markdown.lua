vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" }, { load = function() end })

local filetypes = { "markdown" }

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("RenderMarkdownSetup", { clear = true }),
	pattern = filetypes,
	once = true,
	callback = function()
		vim.cmd.packadd("render-markdown.nvim")
		require("render-markdown").setup({
			file_types = filetypes,
		})
	end,
})
