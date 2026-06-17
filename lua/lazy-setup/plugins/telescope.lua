return {
	{ "nvim-telescope/telescope-ui-select.nvim" },
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			local utils = require("telescope.utils")
			local actions = require("telescope.actions")
			local action_layout = require("telescope.actions.layout")

			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				defaults = {
					layout_strategy = "vertical",
					layout_config = {
						vertical = {
							preview_height = 0.7,
							width = 0.99,
							horizontal = 0.99,
							prompt_position = "bottom",
						},
					},
					sorting_strategy = "descending",
					color_devicons = true,
					file_ignore_patterns = {
						"node_modules",
						".git$", --[[ "lib/*" ]] --[[ "assets/*" ]]
					},
					mappings = {
						i = {
							["<C-p>"] = actions.move_selection_previous,
							["<C-n>"] = actions.move_selection_next,
							["<C-e>"] = action_layout.toggle_preview,
							["<C-o>"] = function(p_bufnr)
								actions.send_selected_to_qflist(p_bufnr)
								vim.cmd.cfdo("edit")
							end,
							["<C-r>"] = actions.delete_buffer,
							["<C-q>"] = function(p_bufnr)
								actions.send_to_qflist(p_bufnr)
								actions.open_qflist(p_bufnr)
							end,
						},
						n = {
							["<C-o>"] = function(p_bufnr)
								actions.send_selected_to_qflist(p_bufnr)
								vim.cmd.cfdo("edit")
							end,
							["<C-r>"] = actions.delete_buffer,
							["<C-e>"] = action_layout.toggle_preview,
							["<C-p>"] = actions.move_selection_previous,
							["<C-n>"] = actions.move_selection_next,
						},
					},
				},
			})

			-- View current buffers
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})

                        -- View current list of marks
			vim.keymap.set("n", "<leader>mm", builtin.marks)

			-- Files search
			vim.keymap.set("n", "<leader>du", builtin.find_files, {})

			vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})

			-- File search relative to current file's directory
			vim.keymap.set("n", "<leader>cd", function()
				builtin.find_files({ cwd = utils.buffer_dir() })
			end, {})

			vim.keymap.set("n", "<leader>gs", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end)

                        -- take qflist
			vim.keymap.set("n", "<leader>tq", function()
				builtin.quickfix()
			end)

                        -- take loclist
			vim.keymap.set("n", "<leader>tl", function()
                                builtin.loclist()
			end)

			vim.keymap.set("n", "<leader>gS", function()
				local word = vim.fn.expand("<cword>")
				builtin.grep_string({ search = word })
			end)

			-- Grep relative to opened project directory
			vim.keymap.set("n", "<leader>mg", function()
				builtin.grep_string({ search = vim.fn.input("Grep > ") })
			end)

			-- Grep relative to current file's directory
			vim.keymap.set("n", "<leader>rg", function()
				builtin.grep_string({ search = vim.fn.input("Relative Grep > "), cwd = utils.buffer_dir() })
			end)

			vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})

			require("telescope").load_extension("ui-select")
		end,
	},
}
