local status_ok, translate = pcall(require, "translate")
if not status_ok then
	return
end

vim.g.deepl_api_auth_key = os.getenv("DEEPL_API_AUTH_KEY")

translate.setup({
	default = {
		command = "deepl_free",
		output = "floating",
	},
	preset = {
		output = {
			insert = {
				base = "top",
				off = -1,
			},
		},
	},
})

local keymap = vim.api.nvim_set_keymap
keymap(
	"n",
	"tr",
	":Translate ZH -source=EN  -output=floating<cr>",
	{ noremap = true, silent = true }
)
keymap(
	"x",
	"tr",
	":Translate ZH -source=EN  -output=floating<cr>",
	{ noremap = true, silent = true }
)
keymap(
	"v",
	"tr",
	":Translate ZH -source=EN  -output=floating<cr>",
	{ noremap = true, silent = true }
)
