local hover = vim.lsp.buf.hover
---@diagnostic disable-next-line: duplicate-set-field
vim.lsp.buf.hover = function()
	return hover({
		max_width = 100,
		max_height = 14,
		border = "single",
	})
end
-- much appreciation to https://github.com/ryanthedev
local on_lsp_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local telescope = require("telescope.builtin")
	vim.keymap.set("n", "gt", function()
		telescope.lsp_type_definitions()
	end, opts)
	vim.keymap.set("n", "gr", function()
		telescope.lsp_references()
	end, opts)
	vim.keymap.set("n", "<leader>gi", function()
		telescope.lsp_implementations()
	end, opts)
	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "ge", function()
		telescope.diagnostics()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>va", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>rn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "dq", function()
		vim.diagnostic.setloclist()
	end, opts)
	vim.keymap.set("n", "dQ", function()
		vim.diagnostic.setqflist()
	end, opts)
end

return {
	{ "hrsh7th/nvim-cmp", enabled = false },
	{ "hrsh7th/cmp-nvim-lsp", enabled = false },
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		config = function()
			require("symbol-usage").setup()
		end,
	},
	{
		"towolf/vim-helm",
		ft = "helm",
	},
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		lazy = true,
		config = false,
		init = function()
			-- Disable automatic setup, we are doing it manually
			vim.g.lsp_zero_extend_cmp = 0
			vim.g.lsp_zero_extend_lspconfig = 0
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = true,
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
	},
	-- LSP
	{
		"neovim/nvim-lspconfig",
		cmd = { "LspInfo", "LspInstall", "LspStart" },
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason-lspconfig.nvim" },
		},
		config = function()
			local lsp_zero = require("lsp-zero")
			lsp_zero.extend_lspconfig()

			lsp_zero.on_attach(function(client, bufnr)
				return on_lsp_attach(client, bufnr)
			end)
			lsp_zero.set_server_config({
				capabilities = {
					textDocument = {
						foldingRange = {
							dynamicRegistration = false,
							lineFoldingOnly = true,
						},
					},
				},
			})

			local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
			lsp_capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			require("mason-lspconfig").setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
					helm_ls = function()
						require("lspconfig").helm_ls.setup({
							capabilities = lsp_capabilities,
							settings = {
								["helm-ls"] = {
									yamlls = {
										path = "yaml-language-server",
									},
								},
							},
						})
					end,
				},
			})

			vim.lsp.config("roslyn", {
				capabilities = lsp_capabilities,
				on_attach = function(client, bufnr)
					return on_lsp_attach(client, bufnr)
				end,
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_implicit_variable_types = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						csharp_enable_inlay_hints_for_types = true,
						dotnet_enable_inlay_hints_for_indexer_parameters = true,
						dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
						dotnet_enable_inlay_hints_for_other_parameters = true,
						dotnet_enable_inlay_hints_for_parameters = true,
						dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
						dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
						dotnet_enable_tests_code_lens = true,
					},
					["csharp|completion"] = {
						dotnet_show_completion_items_from_unimported_namespaces = true,
						dotnet_show_name_completion_suggestions = true,
					},
					["csharp|background_analysis"] = {
						background_analysis_dotnet_compiler_diagnostics_scope = "fullSolution",
					},
					["csharp|symbol_search"] = {
						dotnet_search_reference_assemblies = true,
					},
				},
			})
		end,
	},
	{
		"seblyng/roslyn.nvim",
                ft = "cs",
		opts = {
                        broad_search = true,
			-- your configuration comes here; leave empty for default settings
		},
	},
}
