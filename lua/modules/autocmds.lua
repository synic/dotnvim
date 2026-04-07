local M = {}

function M.setup()
	-- Auto-reload: check for external file changes during common focus and cursor events.
	local autoreload = vim.api.nvim_create_augroup("AutoReload", { clear = true })

	local function checktime_if_idle()
		if vim.fn.getcmdwintype() == "" then
			vim.cmd("checktime")
		end
	end

	vim.api.nvim_create_autocmd("CursorHold", {
		group = autoreload,
		callback = checktime_if_idle,
	})

	vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
		group = autoreload,
		callback = checktime_if_idle,
	})

	vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave" }, {
		group = autoreload,
		callback = checktime_if_idle,
	})
end

return M
