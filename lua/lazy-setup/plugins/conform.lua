return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			-- format_on_save = function(bufnr)
			-- 	if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
			-- 		return
			-- 	end
			-- 	return { timeout_ms = 3000, lsp_fallback = true }
			-- end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform will run multiple formatters sequentially
				python = { "black" },
				-- Use a sub-list to run only the first available formatter
				javascript = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				typescript = { "prettierd" },
				vue = { "prettierd" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				cs = { "csharpier" },
				go = { "gofmt" },
				bash = { "beautysh" },
				shell = { "beautysh" },
				sh = { "beautysh" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				jsx = { "prettierd" },
				tsx = { "prettierd" },
				["_"] = { "trim_whitespace" },
			},
			formatters = {
				-- custom formatter for cs files
				sharpFormat = {
					command = "OmniSharpCodeFormat",
					cwd = require("conform.util").root_file({ "csproj", "sln" }),
				},
			},
		})
	end,
}
