local float_terminal

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        {
            "<leader>tf",
            function()
                if not float_terminal then
                    float_terminal =
                        require("toggleterm.terminal").Terminal:new({ direction = "float", hidden = true })
                end
                float_terminal:toggle()
            end,
            desc = "Floating terminal",
        },
        { "<leader>tb", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Bottom terminal" },
    },
    opts = { size = 15, open_mapping = nil, shade_terminals = false, float_opts = { border = "rounded" } },
    config = function(_, opts)
        require("toggleterm").setup(opts)
        vim.api.nvim_create_autocmd("TermOpen", {
            group = vim.api.nvim_create_augroup("PersonalTerminal", { clear = true }),
            callback = function(event)
                if vim.bo[event.buf].filetype == "toggleterm" then
                    vim.keymap.set(
                        "t",
                        "<Esc><Esc>",
                        [[<C-\><C-n>]],
                        { buffer = event.buf, desc = "Terminal normal mode" }
                    )
                    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { buffer = event.buf })
                    vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { buffer = event.buf })
                    vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { buffer = event.buf })
                    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { buffer = event.buf })
                end
            end,
        })
    end,
}
