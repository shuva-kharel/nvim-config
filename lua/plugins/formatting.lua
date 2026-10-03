return {
    "stevearc/conform.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>cf",
            function()
                require("conform").format({ async = true, lsp_format = "fallback" })
            end,
            mode = { "n", "v" },
            desc = "Format buffer or selection",
        },
        {
            "<leader>cF",
            function()
                vim.b.disable_autoformat = not vim.b.disable_autoformat
                vim.notify("Buffer format on save: " .. (vim.b.disable_autoformat and "off" or "on"))
            end,
            desc = "Toggle buffer format on save",
        },
    },
    opts = {
        formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
            rust = { "rustfmt" },
            python = { "ruff_format" },
            lua = { "stylua" },
            javascript = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            css = { "prettierd", "prettier", stop_after_first = true },
            scss = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            jsonc = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
            markdown = { "prettierd", "prettier", stop_after_first = true },
            sh = { "shfmt" },
            bash = { "shfmt" },
            sql = { "sql_formatter" },
        },
        format_on_save = function(buf)
            if vim.g.disable_autoformat or vim.b[buf].disable_autoformat then
                return
            end
            return { timeout_ms = 1500, lsp_format = "fallback" }
        end,
    },
}
