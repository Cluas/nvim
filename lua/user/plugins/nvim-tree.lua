-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local ok, nvim_tree = pcall(require, "nvim-tree")
if not ok then
	return
end

local config_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_ok then
	return
end

local icons = require("user.icons")

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
	hijack_directories = {
		enable = false,
	},
	update_cwd = true,
	renderer = {
		add_trailing = false,
		group_empty = false,
		highlight_git = false,
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		indent_markers = {
			enable = false,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					arrow_open = icons.ui.ArrowOpen,
					arrow_closed = icons.ui.ArrowClosed,
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = icons.diagnostics.Hint,
			info = icons.diagnostics.Information,
			warning = icons.diagnostics.Warning,
			error = icons.diagnostics.Error,
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	filters = {
		custom = { "^.git$" },
		exclude = { ".vscode" },
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 30,
		hide_root_folder = false,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
				{ key = "h", action = "edit" },
				{ key = "v", cb = tree_cb("vsplit") },
			},
		},
		number = false,
		relativenumber = false,
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		open_file = {
			resize_window = false,
		},
	},
})

local ok, nvim_tree_events = pcall(require, "nvim-tree.events")
if not ok then
	return
end

local ok, bufferline_api = pcall(require, "bufferline.api")
if not ok then
	return
end

local ok, view = pcall(require, "nvim-tree.view")
if not ok then
	return
end

local function get_tree_size()
	return view.View.width
end

nvim_tree_events.subscribe("TreeOpen", function()
	bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("Resize", function()
	bufferline_api.set_offset(get_tree_size())
end)

nvim_tree_events.subscribe("TreeClose", function()
	bufferline_api.set_offset(0)
end)
