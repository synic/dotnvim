local M = {}

local function get_active_client_names()
	local names = {}
	for _, client in ipairs(vim.lsp.get_clients()) do
		names[client.name] = true
	end
	return vim.tbl_keys(names)
end

local function lsp_start(args)
	local server = args.args
	if server == "" then
		vim.notify("Usage: LspStart <server_name>", vim.log.levels.WARN)
		return
	end
	vim.lsp.enable(server)
end

local function lsp_stop(args)
	local arg = args.args
	local clients

	if arg == "" then
		clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
	else
		local id = tonumber(arg)
		if id then
			clients = vim.lsp.get_clients({ id = id })
		else
			clients = vim.lsp.get_clients({ name = arg })
		end
	end

	if not clients or #clients == 0 then
		vim.notify("No matching LSP client found", vim.log.levels.WARN)
		return
	end

	for _, client in ipairs(clients) do
		client:stop()
		vim.notify("Stopped " .. client.name .. " (id: " .. client.id .. ")")
	end
end

local function lsp_restart(args)
	local arg = args.args
	local buf = vim.api.nvim_get_current_buf()
	local clients

	if arg == "" then
		clients = vim.lsp.get_clients({ bufnr = buf })
	else
		local id = tonumber(arg)
		if id then
			clients = vim.lsp.get_clients({ id = id })
		else
			clients = vim.lsp.get_clients({ name = arg })
		end
	end

	if not clients or #clients == 0 then
		vim.notify("No matching LSP client found", vim.log.levels.WARN)
		return
	end

	for _, client in ipairs(clients) do
		local name = client.name
		client:stop()
		vim.defer_fn(function()
			vim.lsp.enable(name)
			vim.notify("Restarted " .. name)
		end, 500)
	end
end

function M.setup()
	vim.api.nvim_create_user_command("LspInfo", ":checkhealth vim.lsp", {
		desc = "Show LSP client information",
	})

	vim.api.nvim_create_user_command("LspStart", lsp_start, {
		nargs = 1,
		desc = "Start an LSP server",
		complete = function()
			return vim.tbl_keys(vim.lsp._configs)
		end,
	})

	vim.api.nvim_create_user_command("LspStop", lsp_stop, {
		nargs = "?",
		desc = "Stop an LSP client (default: all on current buffer)",
		complete = function()
			return get_active_client_names()
		end,
	})

	vim.api.nvim_create_user_command("LspRestart", lsp_restart, {
		nargs = "?",
		desc = "Restart an LSP client (default: all on current buffer)",
		complete = function()
			return get_active_client_names()
		end,
	})

	vim.api.nvim_create_user_command("LspLog", function()
		vim.cmd.edit(vim.lsp.log.get_filename())
	end, {
		desc = "Open the LSP log file",
	})
end

return M
