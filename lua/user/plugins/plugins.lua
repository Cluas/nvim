local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here

return packer.startup(function(use)
	-- Plugin manager
	use("wbthomason/packer.nvim") -- Have packer manage itself

	-- Lua development
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	use("folke/neodev.nvim")

	use({
		"beauwilliams/focus.nvim",
		config = function()
			require("focus").setup()
		end,
	})

	-- Dashboard
	use("goolord/alpha-nvim")

	-- Editing support
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim") -- Easily comment stuff

	-- File exporter
	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")
	use("echasnovski/mini.icons")

	-- StatusLine
	use("nvim-lualine/lualine.nvim")

	-- Bufferline
	use("romgrk/barbar.nvim")

	-- Project
	use("ahmedkhalf/project.nvim")

	-- Terminal
	use("akinsho/toggleterm.nvim")

	-- Indent
	use("lukas-reineke/indent-blankline.nvim")

	-- Utility
	use("moll/vim-bbye")
	use("lewis6991/impatient.nvim")
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	})

	-- Keybindings
	use("folke/which-key.nvim")

	-- Tools
	use("uga-rosa/translate.nvim") -- translate

	use({
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
		config = function()
			require("obsidian").setup({
				workspaces = {
					{
						name = "cluas",
						path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/cluas",
					},
				},
				-- see below for full list of options 👇
			})
		end,
	})

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	use("lunarvim/darkplus.nvim")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("hrsh7th/cmp-nvim-lsp") -- lsp completions
	use("hrsh7th/cmp-nvim-lua") -- lua completions
	use("hrsh7th/cmp-emoji") -- emoji completions
	use("hrsh7th/cmp-nvim-lsp-signature-help") -- lsp signature completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("simrat39/symbols-outline.nvim")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("RRethy/vim-illuminate")
	use("SmiteshP/nvim-navic")

	-- Rust
	use("simrat39/rust-tools.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
	use("nvim-telescope/telescope-ui-select.nvim")
	use("nvim-telescope/telescope-file-browser.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("nvim-treesitter/playground")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("m-demare/hlargs.nvim")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("f-person/git-blame.nvim")

	-- Tool Manager
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Useful status updates for LSP
	use("j-hui/fidget.nvim")

	-- DAP
	use("mfussenegger/nvim-dap")
	use("theHamsta/nvim-dap-virtual-text")
	use("rcarriga/nvim-dap-ui")
	use("leoluz/nvim-dap-go")

	-- Lua
	use("nanotee/luv-vimdocs")
	use("milisims/nvim-luaref")

	use({
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("user.plugins.copilot")
			end, 100)
		end,
	})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
