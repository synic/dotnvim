vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",
	"https://github.com/windwp/nvim-ts-autotag",
})

local treesitter_group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = treesitter_group,
	pattern = "*",
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	group = treesitter_group,
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
	end,
})

vim.hl = vim.highlight -- treesitter workaround

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		require("treesitter-context").setup({ max_lines = 7 })
		require("nvim-treesitter").setup({
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
				disable = { "dart", "htmldjango" },
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@block.outer"] = "V",
					["@conditional.outer"] = "V",
					["@loop.outer"] = "V",
					["@class.outer"] = "V", -- blockwise
				},
				include_surrounding_whitespace = false,
			},
			move = {
				set_jumps = true,
			},
		})
		require("nvim-treesitter").install(require("modules.lsp").langs)
	end,
})
