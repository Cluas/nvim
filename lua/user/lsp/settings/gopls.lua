local util = require("lspconfig/util")
local lastRootPath = nil
local gopath = os.getenv("GOPATH")
if gopath == nil then
	gopath = ""
end
local gopathmod = gopath .. "/pkg/mod"

return {
	analyses = { unusedparams = true, unreachable = false },
	usePlaceholders = true,
	completeUnimported = true,
	staticcheck = true,
	matcher = "Fuzzy",
	symbolMatcher = "fuzzy",
	gofumpt = true,
	buildFlags = { "-tags", "integration" },
	root_dir = function(fname)
		local fullpath = vim.fn.expand(fname .. ":p")
		if string.find(fullpath, gopathmod) and lastRootPath ~= nil then
			return lastRootPath
		end
		lastRootPath = util.root_pattern("go.work")(fname) or util.root_pattern("go.mod", ".git")(fname)
		return lastRootPath
	end,
}
