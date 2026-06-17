return {
	"vim-autoformat/vim-autoformat",
	config = function()
		vim.keymap.set("n", "<leader>f", "<cmd>Autoformat<CR>")
	end,
}
