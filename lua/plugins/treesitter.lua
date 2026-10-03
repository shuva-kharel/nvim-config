local parsers = {
    "bash",
    "c",
    "cpp",
    "rust",
    "python",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "scss",
    "json",
    "jsonc",
    "lua",
    "yaml",
    "toml",
    "markdown",
    "markdown_inline",
    "sql",
    "dockerfile",
    "git_config",
    "cmake",
}
local has_compiler = false
for _, compiler in ipairs({ "cc", "gcc", "clang", "cl", "zig" }) do
    if vim.fn.executable(compiler) == 1 then
        has_compiler = true
        break
    end
end

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- Parser builds need a compiler; skip automatic installs on machines without one.
    opts = {
        ensure_installed = has_compiler and parsers or {},
        auto_install = false,
        highlight = { enable = true },
        indent = { enable = true, disable = { "python", "yaml" } },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
