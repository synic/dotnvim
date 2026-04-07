return {
	servers = {
		["vimls"] = {
			mason_name = "vim-language-server",
			cmd = { "vim-language-server" },
			init_options = {
				isNeovim = true,
				iskeyword = "@,48-57,_,192-255,-#",
				vimruntime = "",
				runtimepath = "",
				diagnostic = { enable = true },
				indexes = {
					runtimepath = true,
					gap = 100,
					count = 3,
					projectRootPatterns = { "runtime", "nvim", ".git", "autoload", "plugin" },
				},
				suggest = { fromVimruntime = true, fromRuntimepath = true },
			},
		},
	},
}
