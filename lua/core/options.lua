vim.opt.guicursor = ""

vim.opt.clipboard = "unnamedplus"
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.encoding = "utf-8"
vim.opt.bomb = false

vim.opt.statusline = "%<%f [%{&fenc != '' ? &fenc : &enc}] %h%m%r%=%-14.(%l,%c%V%) %P"


vim.opt.nu = true
vim.opt.relativenumber = false

vim.opt.tabstop = 8
vim.opt.softtabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.colorcolumn = "120"

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.g.mapleader = " "

vim.opt.background = "light"
vim.cmd("colorscheme default")

vim.filetype.add({ extension = { ejs = "ejs" } })

vim.api.nvim_create_user_command("Cp", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Copy file name command
vim.api.nvim_create_user_command("Cfn", function()
	local path = vim.fn.expand("%:t")
	path = path:match("^(.+)%..+")
	-- check reg available
	if vim.fn.reg_recording() == 0 then
		vim.notify("Clipboard is not available!")
		vim.fn.setreg('"', path)
		return
	end
	vim.fn.setreg("+", path)
	vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- NVIM appearence adjustments
-- Might be put to the init hooks of lsp configuration
vim.diagnostic.config({
	virtual_text = {
		prefix = "# ",
	},
	float = { border = "single" },
})

