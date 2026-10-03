return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        spec = {
            { "<leader>f", group = "Find" },
            { "<leader>g", group = "Git" },
            { "<leader>c", group = "Code" },
            { "<leader>d", group = "Debug" },
            { "<leader>t", group = "Terminal" },
            { "<leader>b", group = "Buffers" },
            { "<leader>s", group = "Splits" },
        },
    },
}
