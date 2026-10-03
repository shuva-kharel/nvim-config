return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
        {
            "<leader>ff",
            function()
                require("telescope.builtin").find_files({ hidden = true })
            end,
            desc = "Find files",
        },
        {
            "<leader>fg",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Live grep",
        },
        {
            "<leader>fb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>fh",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Help",
        },
        {
            "<leader>fr",
            function()
                require("telescope.builtin").oldfiles()
            end,
            desc = "Recent files",
        },
        {
            "<leader>fs",
            function()
                require("telescope.builtin").lsp_document_symbols()
            end,
            desc = "Document symbols",
        },
        {
            "<leader>fS",
            function()
                require("telescope.builtin").lsp_dynamic_workspace_symbols()
            end,
            desc = "Workspace symbols",
        },
    },
    opts = {
        defaults = { path_display = { "smart" } },
        pickers = {
            find_files = {
                find_command = vim.fn.executable("fd") == 1
                        and { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
                    or nil,
            },
        },
    },
}
