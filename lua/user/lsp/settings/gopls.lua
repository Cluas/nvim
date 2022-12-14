return {
	settings = {
		gopls = {
			-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
			-- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
			-- not supported
			analyses = { unusedparams = true, unreachable = false },
			codelenses = {
				generate = true, -- show the `go generate` lens.
				gc_details = true, --  // Show a code lens toggling the display of gc's choices.
				test = true,
				tidy = true,
			},
			usePlaceholders = true,
			completeUnimported = true,
			staticcheck = true,
			matcher = "Fuzzy",
			symbolMatcher = "fuzzy",
			["local"] = "",
			gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
			buildFlags = { "-tags", "integration" },
		},
	},
}
