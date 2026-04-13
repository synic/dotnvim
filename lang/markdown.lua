return {
	nonels = {
		"diagnostics.markdownlint_cli2",
		function()
			local h = require("null-ls.helpers")
			local methods = require("null-ls.methods")
			return h.make_builtin({
				name = "flowmark",
				method = methods.internal.FORMATTING,
				filetypes = { "markdown" },
				generator_opts = {
					command = "flowmark",
					args = { "--width=80", "-", "-o", "-" },
					to_stdin = true,
				},
				factory = h.formatter_factory,
			})
		end,
	},
}
