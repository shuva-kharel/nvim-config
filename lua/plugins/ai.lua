-- Opt in by setting vim.g.enable_copilot = true BEFORE requiring config.lazy.
-- No plugin or service starts in the default configuration.
return {
    "zbirenbaum/copilot.lua",
    enabled = vim.g.enable_copilot == true,
    event = "InsertEnter",
    cmd = "Copilot",
    opts = {
        suggestion = {
            enabled = true,
            auto_trigger = true,
            keymap = { accept = "<M-l>", next = "<M-]>", prev = "<M-[>", dismiss = "<C-]>" },
        },
        panel = { enabled = false },
    },
    config = function(_, opts)
        require("copilot").setup(opts)
        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuOpen",
            callback = function()
                vim.b.copilot_suggestion_hidden = true
            end,
        })
        vim.api.nvim_create_autocmd("User", {
            pattern = "BlinkCmpMenuClose",
            callback = function()
                vim.b.copilot_suggestion_hidden = false
            end,
        })
    end,
}
