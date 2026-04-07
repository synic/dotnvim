local M = {}

function M.setup()
	-- Global leaders used by custom keymaps throughout the config.
	vim.g.mapleader = " "
	vim.g.maplocalleader = ","

	-- Local alias for Neovim's option interface.
	local opt = vim.opt

	-- Editing behavior: make insert-mode editing and hidden buffers less disruptive.
	opt.backspace = "2" -- Allow backspace over indenting, end-of-line, and insert start.
	opt.smartindent = true -- Add basic indentation on new lines after syntax-aware patterns.
	opt.autoindent = true -- Copy the current line's indentation onto the next line.
	opt.hidden = true -- Allow switching buffers without saving first.
	opt.history = 50 -- Keep a small command/search history.

	-- Window and split behavior: prefer predictable horizontal and vertical layouts.
	opt.splitright = true -- Open vertical splits to the right of the current window.
	opt.splitbelow = true -- Open horizontal splits below the current window.
	opt.equalalways = true -- Rebalance window sizes after opening or closing splits.
	opt.scrolloff = 15 -- Keep context above and below the cursor while scrolling.
	opt.cursorbind = false -- Do not sync cursor movement across windows.
	opt.scrollbind = false -- Do not sync scrolling across windows.

	-- Search and completion: keep searching flexible but avoid intrusive defaults.
	opt.incsearch = true -- Show matches incrementally while typing a search.
	opt.hlsearch = false -- Do not keep all search matches highlighted after the search.
	opt.ignorecase = true -- Make searches case-insensitive by default.
	opt.smartcase = true -- Re-enable case-sensitive search when uppercase is used.
	opt.wildmenu = true -- Use the enhanced command-line completion menu.
	opt.wildmode = "longest:full,full" -- Complete to the longest common match, then cycle full matches.
	opt.completeopt = { "menu", "menuone", "noselect" } -- Use popup completion without preselecting an item.
	opt.shortmess:append("I") -- Skip the intro screen at startup.

	-- File handling and persistence: avoid swap/backup files and auto-refresh changed files.
	opt.backup = false -- Do not create backup files when writing.
	opt.writebackup = false -- Do not make a temporary backup before overwriting a file.
	opt.swapfile = false -- Do not use swap files for open buffers.
	opt.autoread = true -- Reload files changed outside Neovim when possible.

	-- Display and UI: tune how buffers, status, and visible whitespace are rendered.
	opt.ruler = true -- Show the cursor position in the command area.
	opt.wrap = false -- Keep long lines on a single screen line.
	opt.visualbell = true -- Use a visual cue instead of an audible bell.
	opt.laststatus = 2 -- Always show the statusline.
	opt.cursorline = true -- Highlight the screen line containing the cursor.
	opt.listchars = { tab = "| ", eol = "↵" } -- Render tabs and end-of-line markers visibly.
	opt.statusline = "%<%n:%f%h%m%r%= %{&ff} %l,%c%V %P" -- Show buffer, file format, and cursor information.
	opt.mousehide = true -- Hide the mouse pointer while typing.
	opt.mousefocus = false -- Do not move focus just because the mouse entered a window.
	opt.mousemodel = "extend" -- Use shift/ctrl mouse selections for extending visual selections.
	opt.mouse = "a" -- Enable mouse support in all modes.
	opt.number = true -- Show absolute line numbers.
	opt.showtabline = 1 -- Show the tabline only when more than one tab exists.
	opt.colorcolumn = "0" -- Disable the color column marker.
	opt.termguicolors = true -- Enable 24-bit color in supported terminals.

	-- Text formatting and indentation: prefer spaces and a fixed text width.
	opt.tabstop = 4 -- Render a tab character as four spaces wide.
	opt.shiftwidth = 4 -- Indent and unindent by four spaces.
	opt.softtabstop = 4 -- Make backspace and tab feel like four spaces in insert mode.
	opt.shiftround = true -- Round indentation to the nearest shiftwidth.
	opt.expandtab = true -- Insert spaces instead of literal tab characters.
	opt.textwidth = 78 -- Auto-wrap text around 78 characters when formatting.
	opt.formatoptions:append("t") -- Enable automatic text wrapping for normal text.

	-- External files and environment: keep encoding and clipboard behavior consistent.
	opt.encoding = "utf-8" -- Use UTF-8 internally.
	opt.clipboard = "unnamed" -- Sync yanks and deletes with the primary system clipboard.

	-- Buffer-local trust and modelines: allow local config files with Neovim safety checks.
	opt.modeline = true -- Read modelines from files.
	opt.modelines = 5 -- Scan the first and last five lines for modelines.
	opt.exrc = true -- Allow per-directory/project `.nvim.lua` and similar local config.
	opt.secure = true -- Restrict unsafe commands when loading local config.

	-- Matching and tabs: make paired delimiters and tabs easier to inspect.
	opt.showmatch = true -- Briefly jump to matching brackets while typing.
	opt.matchtime = 5 -- Keep matching bracket highlights visible for a short time.

	-- Timeout behavior: keep mapped-key sequences responsive.
	vim.o.timeout = true -- Enable timeouts for mapped key sequences.
	vim.o.timeoutlen = 500 -- Wait up to half a second for a mapped sequence to complete.

	-- Swap directory: keep any swap data inside the Neovim config tree.
	local vimhome = vim.fn.stdpath("config") -- Resolve the active Neovim config directory.
	local swapdir = vimhome .. "/swap" -- Store swap files in a dedicated config-local folder.
	vim.fn.mkdir(swapdir, "p") -- Ensure the swap directory exists before using it.
	opt.dir = swapdir -- Point Neovim's swap file directory at the managed folder.

	-- enable floating window for checkhealth
	vim.g.health = { style = "float" }

	-- macOS terminal locale fix: ensure UTF-8 locale is available when missing.
	if vim.fn.has("macunix") == 1 and vim.env.LC_CTYPE == nil then
		vim.env.LC_CTYPE = "en_US.UTF-8"
	end
end

return M
