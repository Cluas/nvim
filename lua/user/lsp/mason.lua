local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

local ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not ok then
	return
end

local servers = {
	"jsonls",
	"gopls",
	"lua_ls",
	"ts_ls",
	"bashls",
	"taplo",
	"rust_analyzer",
}

mason.setup()
mason_lspconfig.setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = nil

local neodev_status_ok, neodev = pcall(require, "neodev")
if neodev_status_ok then
	neodev.setup()
end

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	if server == "rust_analyzer" then
		local rust_opts = require("user.lsp.settings.rust_analyzer")
		local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
		if not rust_tools_status_ok then
			return
		end
		rust_tools.setup(rust_opts)
	end
	if server == "gopls" then
		local gopls_opts = require("user.lsp.settings.gopls")
		opts = vim.tbl_deep_extend("force", gopls_opts, opts)
	end
	lspconfig[server].setup(opts)
end

local fidget_ok, fidget = pcall(require, "fidget")
if not fidget_ok then
	return
end

fidget.setup()
