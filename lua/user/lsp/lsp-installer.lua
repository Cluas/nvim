local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

mason_lspconfig.setup_handlers({
	-- The first entry (without a key) will be the default handler
	-- and will be called for each installed server that doesn't have
	-- a dedicated handler.
	function(server_name) -- default handler (optional)
		local opts = {
			on_attach = require("user.lsp.handlers").on_attach,
			capabilities = require("user.lsp.handlers").capabilities,
		}
		if server_name == "sumneko_lua" then
			local sumneko_opts = require("user.lsp.settings.sumneko_lua")
			opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
		end

		if server_name == "gopls" then
			local gopls_opts = require("user.lsp.settings.gopls")
			opts = vim.tbl_deep_extend("force", gopls_opts, opts)
		end
		require("lspconfig")[server_name].setup(opts)
	end,
})

mason_lspconfig.setup(
  {
     ensure_installed = { "sumneko_lua", "rust_analyzer", "gopls" }
  }
)
