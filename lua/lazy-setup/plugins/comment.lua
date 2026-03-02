-- TODO: replace with my komment plugin, no need for ext deps really
return {
    'numToStr/Comment.nvim',
    config = function()
        require("Comment").setup({
            ---Add a space b/w comment and the line
            padding = true,
            ---Whether the cursor should stay at its position
            sticky = false,
            ---Lines to be ignored while (un)comment
            ignore = "^$",
            ---LHS of toggle mappings in NORMAL mode
            toggler = {
                ---Line-comment toggle keymap
                line = 'zc',
                ---Block-comment toggle keymap
                block = 'zC',
            },

            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                ---Line-comment keymap
                line = '<leader>k',
                ---Block-comment keymap
                block = '<leader>K',
            },
            ---Enable keybindings
            ---NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                basic = true,
                ---Extra mapping; `gco`, `gcO`, `gcA`
                extra = false,
            },
            ---Function to call before (un)comment
            pre_hook = nil,
            -- -Function to call after (un)comment
            post_hook = nil,
        })
    end
}
