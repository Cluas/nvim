local status_ok, _ = pcall(require, "dap")
if not status_ok then
	return
end
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

