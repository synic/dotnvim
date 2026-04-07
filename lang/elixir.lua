return {
	treesitter = { "elixir", "heex" },
	servers = {
		expert = {
			-- using Jump's `mix expert_ls install`, which adds a `start_expert.sh` wrapper
			cmd = { "start_expert.sh" },
			use_mason = false,
		},
	},
}
