local group = vim.api.nvim_create_augroup("PersonalConfig", { clear = true })
-- Four spaces remain the default; web formats normally use two.
vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "html",
        "css",
        "scss",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "dockerfile",
    },
    callback = function()
        vim.bo.shiftwidth = 2
        vim.bo.tabstop = 2
    end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function()
        vim.hl.on_yank({ timeout = 150 })
    end,
})
