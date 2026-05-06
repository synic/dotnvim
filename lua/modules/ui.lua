-- @diagnostic disable: inject-field
local proj = require("modules.projects")

local M = {}

function M.zoom_toggle()
	if vim.t.zoomed then
		vim.fn.execute(vim.t.zoom_winrestcmd)
		vim.t.zoomed = false
	else
		vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
		vim.t.zoomed = true
		vim.cmd("resize")
		vim.cmd("vertical resize")
	end
end

function M.close_all_floating_windows()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= "" then -- is_floating_window?
			vim.api.nvim_win_close(win, false) -- do not force
		end
	end
end

---@param full? boolean
function M.buffer_copy_path(full)
	local pattern = "%p"

	if full then
		pattern = "%:p"
	end

	local path = vim.fn.expand(pattern)
	vim.fn.setreg("+", path)
	vim.notify("Copied to clipboard: " .. path)
end

function M.buffer_copy_full_path()
	M.buffer_copy_path(true)
end

function M.buffer_copy_path_and_line()
	local mode = vim.fn.mode()

	if mode == "V" then
		local filetype = vim.bo.filetype
		local start_pos = vim.fn.getpos("v")
		local end_pos = vim.fn.getpos(".")
		local start_line = math.min(start_pos[2], end_pos[2])
		local pattern = "%p"
		local path = vim.fn.expand(pattern)
		local path_with_line = string.format("%s:%d", path, start_line)

		vim.cmd([[silent normal! "xy]])
		local selected_text = vim.fn.getreg("x")

		local result = string.format("%s\n\n```%s\n%s\n```\n\n", path_with_line, filetype, selected_text)

		vim.fn.setreg("+", result)
		vim.notify("Copied selection with path to clipboard")
	else
		local edit = require("modules.edit")
		local path_with_line = edit.get_path_with_line_info()
		vim.fn.setreg("+", path_with_line)
		vim.notify("Copied to clipboard: " .. path_with_line)
	end
end

-- excluding the current window, move all cursors to 0 position on their current line
-- for all windows in the current tab
---@param tabnr? integer
---@param exclude_current? boolean
function M.zero_window_cursors(tabnr, exclude_current)
	local current = vim.fn.winnr()

	for nr, _ in ipairs(vim.api.nvim_tabpage_list_wins(tabnr or 0)) do
		if current ~= nr or not exclude_current then
			vim.cmd(nr .. "windo norm 0")
		end
	end

	vim.cmd(current .. "windo normal! m'")
end

---@param tabnr? integer
function M.zero_all_window_cursors(tabnr)
	M.zero_window_cursors(tabnr, true)
end

-- Execute a command across all tabs
---@param cmd string
function M.tabdo(cmd)
	local current_tab = vim.fn.tabpagenr()
	vim.cmd("tabdo " .. cmd)
	vim.cmd(current_tab .. "tabnext") -- restore original tab position
end

-- Equalize windows in all tabs
function M.equalize_all_tabs()
	M.tabdo("wincmd =")
end

function M.quickfix_remove_item_move_next()
	vim.cmd.copen()
	local curqfidx = vim.fn.line(".")
	local qfall = vim.fn.getqflist()

	if #qfall == 0 then
		return
	end

	table.remove(qfall, curqfidx)

	vim.fn.setqflist(qfall, "r")

	if #qfall == 0 then
		return
	end

	local new_idx = curqfidx < #qfall and curqfidx or math.max(curqfidx - 1, 1)
	vim.api.nvim_win_set_cursor(vim.fn.win_getid(), { new_idx, 0 })
	vim.cmd("cc" .. new_idx)
end

function M.layout_set_name()
	---@diagnostic disable-next-line: missing-fields
	vim.ui.input({ prompt = "layout name: ", default = (vim.t.layout_name or "") }, function(name)
		if name then
			---@diagnostic disable-next-line: inject-field
			vim.t.layout_name = name
			vim.cmd.redrawtabline()
		end
	end)
end

function M.goto_lazy_dir()
	local path = vim.fn.resolve(vim.fn.stdpath("data") .. "/" .. "lazy")
	local ok, _ = pcall(require, "snacks")

	if ok then
		require("modules.picker").dir_picker(path, "Plugins")
	else
		vim.cmd.edit(path)
	end
end

function M.goto_dotfiles_dir()
	vim.cmd.edit(vim.fn.expand("~/.dotfiles"))
end

function M.golden_ratio_toggle()
	vim.cmd.GoldenRatioToggle()
	if vim.g.golden_ratio_enabled == 0 then
		---@diagnostic disable-next-line: inject-field
		vim.g.golden_ratio_enabled = 1
		vim.notify("Golden Ratio: enabled")
	else
		---@diagnostic disable-next-line: inject-field
		vim.g.golden_ratio_enabled = 0
		vim.notify("Golden Ratio: disabled")
		---@diagnostic disable-next-line: inject-field
		vim.g.equalalways = true
		M.equalize_all_tabs()
	end
end

---@param tabnr integer
---@return string|nil
function M.get_tab_name(tabnr)
	return proj.get_name(tabnr)
end

return M
