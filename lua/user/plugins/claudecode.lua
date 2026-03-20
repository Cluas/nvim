local status_ok, claudecode = pcall(require, "claudecode")
if not status_ok then
	return
end

claudecode.setup({
	terminal = {
		split_side = "right",
		split_width_percentage = 0.30,
	},
})

--- Paste clipboard image as file path in terminal mode.
--- If clipboard has an image, save it via pngpaste and send the path.
--- Otherwise, fall back to normal paste.
local function paste_image_or_text()
	local img_dir = vim.fn.getcwd() .. "/.claude/images"
	local timestamp = os.date("%Y%m%d_%H%M%S")
	local img_path = img_dir .. "/" .. timestamp .. ".png"

	-- Try pngpaste to check if clipboard has an image
	local check = vim.fn.system("pngpaste - > /dev/null 2>&1; echo $?")
	if vim.trim(check) == "0" then
		vim.fn.mkdir(img_dir, "p")
		vim.fn.system("pngpaste " .. vim.fn.shellescape(img_path))
		-- Send the file path to the terminal
		vim.api.nvim_feedkeys(img_path, "n", false)
	else
		-- No image in clipboard, do normal paste
		local reg = vim.fn.getreg("+")
		vim.api.nvim_feedkeys(reg, "n", false)
	end
end

local map = vim.keymap.set
map("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
map("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
map("t", "<F13>", paste_image_or_text, { desc = "Paste image path or text" })
