local proj = require("modules.projects")

local M = {}

function M.search_cwd()
	---@diagnostic disable-next-line: missing-fields
	require("snacks").picker.grep({ cwd = proj.get_buffer_cwd() })
end

function M.find_files_cwd()
	---@diagnostic disable-next-line: missing-fields
	require("snacks").picker.files({ cwd = proj.get_buffer_cwd() })
end

M.browse_directory = function(type, precmd)
	return function()
		if precmd then
			vim.cmd[precmd]()
		end

		if type == "current" then
			-- oil is a bit strange, if you pass no arguments, it does not open in `vim.uv.cwd()` like telescope. It always
			-- opens in the current buffer's directory. If you pass a path, it won't select the current buffer's file
			-- automatically.
			vim.cmd.Oil()
		else
			local pathname = proj.get_root()
			vim.cmd.Oil((pathname or "."))
		end
	end
end

function M.goto_config_directory()
	---@diagnostic disable-next-line: param-type-mismatch
	proj.open(vim.fn.stdpath("config"))
end

return M
