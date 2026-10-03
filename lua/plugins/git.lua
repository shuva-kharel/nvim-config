return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        on_attach = function(buf)
            local gs = require("gitsigns")
            local map = function(lhs, rhs, desc, mode)
                vim.keymap.set(mode or "n", lhs, rhs, { buffer = buf, desc = desc })
            end
            map("]h", function()
                gs.nav_hunk("next")
            end, "Next hunk")
            map("[h", function()
                gs.nav_hunk("prev")
            end, "Previous hunk")
            map("<leader>gp", gs.preview_hunk, "Preview hunk")
            map("<leader>gs", gs.stage_hunk, "Stage hunk")
            map("<leader>gr", gs.reset_hunk, "Reset hunk")
            map("<leader>gS", gs.stage_buffer, "Stage buffer")
            map("<leader>gb", function()
                gs.blame_line({ full = true })
            end, "Blame line")
            map("<leader>gd", gs.diffthis, "Diff against index")
        end,
    },
}
