return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ts_config = require("nvim-treesitter.configs")

    ts_config.setup({
      ensure_installed = {
        "lua",
        "javascript",
        "python",
        "cpp",
        "c",
        "html",
        "css",
        "markdown",
        "bash",
      },
      sync_install = false,
      highlight = {
        enable = true, -- Enable Treesitter-based highlighting
      },
      indent = {
        enable = true, -- Enable Treesitter-based indentation
      },
      -- Optionally enable other features like folding, rainbow brackets, etc.
      -- textobjects = { enable = true },   -- Enable text objects support
      -- rainbow = { enable = true },       -- Enable rainbow parentheses
    })
  end,
}
