return {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    opts = {
        keymap = {
            preset = "none",
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
            ["<CR>"] = { "accept", "fallback" },
            ["<C-e>"] = { "hide", "fallback" },
            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },
            ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
            ["<C-l>"] = { "snippet_forward", "fallback" },
            ["<C-h>"] = { "snippet_backward", "fallback" },
        },
        completion = {
            documentation = { auto_show = true, auto_show_delay_ms = 300 },
            list = { selection = { preselect = false, auto_insert = false } },
        },
        signature = { enabled = true },
        sources = { default = { "lsp", "path", "snippets", "buffer" } },
        appearance = { nerd_font_variant = "mono" },
    },
}
