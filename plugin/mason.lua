vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
})

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local lsp = require("modules.lsp")
		require("mason").setup({})

		local registry = require("mason-registry")
		registry.refresh(function()
			local to_install = {}
			for _, pkg_name in ipairs(lsp.mason_servers) do
				local ok, pkg = pcall(registry.get_package, pkg_name)
				if ok and not pkg:is_installed() then
					table.insert(to_install, pkg)
				end
			end

			local installed = 0
			for _, pkg in ipairs(to_install) do
				vim.print("Installing language server " .. pkg.name .. "...")
				pkg:install():once(
					"closed",
					vim.schedule_wrap(function()
						if pkg:is_installed() then
							installed = installed + 1
						end
						if installed == #to_install then
							vim.print("")
							vim.notify("Successfully installed " .. installed .. " language servers.")
						end
					end)
				)
			end
		end)
	end,
})
