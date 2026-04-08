local M = {}

function M.select(query)
	require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
end

function M.goto_next_start(query)
	require("nvim-treesitter-textobjects.move").goto_next_start(query, "textobjects")
end

function M.goto_next_end(query)
	require("nvim-treesitter-textobjects.move").goto_next_end(query, "textobjects")
end

function M.goto_previous_start(query)
	require("nvim-treesitter-textobjects.move").goto_previous_start(query, "textobjects")
end

function M.goto_previous_end(query)
	require("nvim-treesitter-textobjects.move").goto_previous_end(query, "textobjects")
end

return M
