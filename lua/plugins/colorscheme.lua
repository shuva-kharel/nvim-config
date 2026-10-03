return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = false,
        opts = {
            flavour = "mocha",
            transparent_background = false,
            integrations = {
                treesitter = true,
                telescope = { enabled = true },
                neotree = true,
                gitsigns = true,
                which_key = true,
                blink_cmp = true,
                lualine = true,
                dap = true,
                dap_ui = true,
            },
        },
        config = function(_, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    { "nvim-tree/nvim-web-devicons", lazy = true },
}
