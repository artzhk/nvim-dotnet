local autocmd_group = vim.api.nvim_create_augroup("Custom auto-commands", { clear = true })
local gitlens = require("core.utils.gitlens")
local colorscheme = require("core.utils.colorscheme")

vim.api.nvim_create_autocmd({ "CursorMoved" }, {
	pattern = "*",
	desc = "Clear blame virt text",
	callback = function()
		gitlens.clearBlameVirtText()
	end,
	group = autocmd_group,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function(_)
                colorscheme.configure()
	end,
})

-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	desc = "Remove bomb if presented",
-- 	callback = function()
-- 		-- leverage not deprecated version
-- 		local is_bomb = vim.api.nvim_exec("setlocal bomb?", true)
-- 		print(is_bomb)
-- 		if string.match(is_bomb, "nobomb") then
-- 			return
-- 		end

-- 		vim.cmd("setlocal nobomb")
-- 	end,
-- })

-- wrap long lines in quickfix window
vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		vim.opt_local.wrap = true
	end,
	group = autocmd_group,
})

-- trigger autoread when focus returns or buffer is entered
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	pattern = "*",
	command = "checktime",
	group = autocmd_group,
})

local M = {}

M.eslint_on_save = function(_, buffer)
	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = buffer,
		command = "EslintFixAll",
	})
end

return M
