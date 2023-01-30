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
	"sumneko_lua",
	"gopls",
	"tsserver",
	"yamlls",
	"bashls",
	"rust_analyzer",
}


mason.setup()
mason_lspconfig.setup({
	ensure_installed = servers,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = nil

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "rust_analyzer" then
		local rust_opts = require("user.lsp.settings.rust_analyzer")
		local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
		if not rust_tools_status_ok then
			return
		end

		rust_tools.setup(rust_opts)
		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end


local fidget_ok, fidget = pcall(require, "fidget")
if not fidget_ok then
	return
end

fidget.setup()

