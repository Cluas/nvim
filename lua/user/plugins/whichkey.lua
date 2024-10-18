local ok, which_key = pcall(require, "which-key")
if not ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	keys = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	win = {
		-- don't allow the popup to overlap with the cursor
		no_overlap = false,
		-- width = 1,
		-- height = { min = 4, max = 25 },
		-- col = 0,
		-- row = math.huge,
		border = "rounded",
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		title = true,
		title_pos = "center",
		zindex = 1000,
		-- Additional vim.wo and vim.bo options
		bo = {},
		wo = {
			winblend = 10,
		  -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		},
	  },
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	show_help = true, -- show a help message in the command line for using WhichKey
	show_keys = true, -- show the currently pressed key and its label as a message in the command line
	triggers = {
		{ "<auto>", mode = "nxso" },
		{ "<leader>", mode = "nxso" },
		{ "j", mode = "iv" },
		{ "k", mode = "iv" },
	},
}

which_key.add({
	{"<silent>", hidden = true},
	{"<cmd>", hidden = true},
	{"Cmd", hidden = true},
	{"CR", hidden = true},
	{"call", hidden = true},
	{"lua", hidden = true},
	{"^:", hidden = true},
	{"^ ", hidden = true},
})

local mappings =  {
    { "<leader><space>", "<cmd>Telescope buffers<cr>", desc = "[ ] Find existing buffers", nowait = true, remap = false },
    { "<leader>F", "<cmd>Telescope live_grep theme=ivy<cr>", desc = "Find Text", nowait = true, remap = false },
    { "<leader>P", "<cmd>lua require('telescope').extensions.projects.projects()<cr>", desc = "Projects", nowait = true, remap = false },
    { "<leader>a", "<cmd>Alpha<cr>", desc = "Alpha", nowait = true, remap = false },
    { "<leader>b", "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Buffers", nowait = true, remap = false },
    { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
    { "<leader>d", group = "Debugger", nowait = true, remap = false },
    { "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", desc = "Toggle Breakpoint", nowait = true, remap = false },
    { "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", desc = "Continue", nowait = true, remap = false },
    { "<leader>ds", group = "Setp", nowait = true, remap = false },
    { "<leader>dsc", "<cmd>lua require'dap'.step_over()<cr>", desc = "Step Over", nowait = true, remap = false },
    { "<leader>dsi", "<cmd>lua require'dap'.step_into()<cr>", desc = "Step Into", nowait = true, remap = false },
    { "<leader>dso", "<cmd>lua require'dap'.step_out()<cr>", desc = "Step Out", nowait = true, remap = false },
    { "<leader>dt", "<cmd>lua require'user.nvim-dap'.terminate()<cr>", desc = "Stop", nowait = true, remap = false },
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer", nowait = true, remap = false },
    { "<leader>f", "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find files", nowait = true, remap = false },
    { "<leader>g", group = "Git", nowait = true, remap = false },
    { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", desc = "Reset Buffer", nowait = true, remap = false },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit", nowait = true, remap = false },
    { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>", desc = "Diff", nowait = true, remap = false },
    { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit", nowait = true, remap = false },
    { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", desc = "Next Hunk", nowait = true, remap = false },
    { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", desc = "Prev Hunk", nowait = true, remap = false },
    { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>", desc = "Blame", nowait = true, remap = false },
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file", nowait = true, remap = false },
    { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", desc = "Preview Hunk", nowait = true, remap = false },
    { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", desc = "Reset Hunk", nowait = true, remap = false },
    { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", desc = "Stage Hunk", nowait = true, remap = false },
    { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", desc = "Undo Stage Hunk", nowait = true, remap = false },
    { "<leader>h", "<cmd>nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
    { "<leader>l", group = "LSP", nowait = true, remap = false },
    { "<leader>lF", "<cmd>LspToggleAutoFormat<cr>", desc = "Toggle Autoformat", nowait = true, remap = false },
    { "<leader>lI", "<cmd>LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
    { "<leader>lR", "<cmd>Telescope lsp_references<cr>", desc = "References", nowait = true, remap = false },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Code Action", nowait = true, remap = false },
    { "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics", nowait = true, remap = false },
    { "<leader>le", "<cmd>lua vim.lsp.codelens.refresh()<cr>", desc = "CodeLens Refresh", nowait = true, remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format { async = true }<cr>", desc = "Format", nowait = true, remap = false },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info", nowait = true, remap = false },
    { "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", desc = "Next Diagnostic", nowait = true, remap = false },
    { "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", desc = "Prev Diagnostic", nowait = true, remap = false },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action", nowait = true, remap = false },
    { "<leader>lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", desc = "Quickfix", nowait = true, remap = false },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols", nowait = true, remap = false },
    { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
    { "<leader>p", group = "Packer", nowait = true, remap = false },
    { "<leader>pS", "<cmd>PackerStatus<cr>", desc = "Status", nowait = true, remap = false },
    { "<leader>pc", "<cmd>PackerCompile<cr>", desc = "Compile", nowait = true, remap = false },
    { "<leader>pi", "<cmd>PackerInstall<cr>", desc = "Install", nowait = true, remap = false },
    { "<leader>ps", "<cmd>PackerSync<cr>", desc = "Sync", nowait = true, remap = false },
    { "<leader>pu", "<cmd>PackerUpdate<cr>", desc = "Update", nowait = true, remap = false },
    { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },
    { "<leader>s", group = "Search", nowait = true, remap = false },
    { "<leader>sb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch", nowait = true, remap = false },
    { "<leader>sc", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme", nowait = true, remap = false },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostic", nowait = true, remap = false },
    { "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Files", nowait = true, remap = false },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help", nowait = true, remap = false },
    { "<leader>sr", "<cmd>telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },
    { "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Current word", nowait = true, remap = false },
    { "<leader>t", group = "Terminal", nowait = true, remap = false },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float", nowait = true, remap = false },
    { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", nowait = true, remap = false },
    { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>", desc = "Python", nowait = true, remap = false },
    { "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>", desc = "Htop", nowait = true, remap = false },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical", nowait = true, remap = false },
    { "<leader>w", "<cmd>w!<CR>", desc = "Save", nowait = true, remap = false },
  }


which_key.add(mappings)
which_key.setup(setup)
