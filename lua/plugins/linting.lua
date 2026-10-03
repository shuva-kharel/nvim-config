return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local lint = require("lint")
        -- Basedpyright handles types; Ruff handles Python style. ESLint and
        -- ShellCheck add rules that their language servers do not provide.
        lint.linters_by_ft = {
            python = { "ruff" },
            javascript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            sh = { "shellcheck" },
            bash = { "shellcheck" },
        }
        vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
            group = vim.api.nvim_create_augroup("PersonalLint", { clear = true }),
            callback = function()
                lint.try_lint(nil, { ignore_errors = true })
            end,
        })
    end,
}
